/* =====================================================================
   AJUSTE DE TABELA
   ===================================================================== */
ALTER TABLE musica
ADD COLUMN IF NOT EXISTS reproducoes_total BIGINT DEFAULT 0;


/* =====================================================================
   =========  FUNÇÕES BÁSICAS (já existentes no seu código)  ============
   ===================================================================== */
CREATE OR REPLACE FUNCTION fn_add_musica_playlist(
    p_playlist_id INT,
    p_musica_id   INT
) RETURNS VOID AS $$
DECLARE
    v_next_ordem INT;
BEGIN
    SELECT COALESCE(MAX(ordem),0)+1
      INTO v_next_ordem
      FROM playlist_musica
     WHERE id_playlist = p_playlist_id;

    INSERT INTO playlist_musica (id_playlist, id_musica, ordem)
    VALUES (p_playlist_id, p_musica_id, v_next_ordem);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION fn_toggle_curtida(
    p_usuario_id INT,
    p_musica_id  INT
) RETURNS TEXT AS $$
BEGIN
    IF EXISTS (SELECT 1
                 FROM curtidas
                WHERE id_usuario = p_usuario_id
                  AND id_musica  = p_musica_id) THEN
        DELETE FROM curtidas
         WHERE id_usuario = p_usuario_id
           AND id_musica  = p_musica_id;
        RETURN 'Curtida removida';
    ELSE
        INSERT INTO curtidas (id_usuario, id_musica, data_curtida, "createdAt", "updatedAt")
        VALUES (p_usuario_id, p_musica_id, NOW(), NOW(), NOW());
        RETURN 'Curtida adicionada';
    END IF;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION fn_top_musicas_usuario(
    p_usuario_id INT,
    p_limite     INT DEFAULT 10
) RETURNS TABLE(
    id_musica INT,
    titulo    VARCHAR,
    total_reproducoes BIGINT
) AS $$
BEGIN
    RETURN QUERY
    SELECT m.id_musica,
           m.titulo,
           COUNT(*) AS total_reproducoes
      FROM historico_reproducao h
      JOIN musica m ON m.id_musica = h.id_musica
     WHERE h.id_usuario = p_usuario_id
     GROUP BY m.id_musica, m.titulo
     ORDER BY total_reproducoes DESC
     LIMIT p_limite;
END;
$$ LANGUAGE plpgsql;


/* =====================================================================
   ======================  TRIGGER DE INSERT  ==========================
   ===================================================================== */
CREATE OR REPLACE FUNCTION trgfn_incrementa_reproducoes()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE musica
       SET reproducoes_total = reproducoes_total + 1
     WHERE id_musica = NEW.id_musica;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_incrementa_reproducoes
AFTER INSERT ON historico_reproducao
FOR EACH ROW
EXECUTE PROCEDURE trgfn_incrementa_reproducoes();


/* =====================================================================
   =========  FUNÇÕES / TRIGGERS EXTRA (manutenção avançada)  ===========
   ===================================================================== */
-- 1. AFTER DELETE: decrementa contagem
CREATE OR REPLACE FUNCTION trgfn_decrementa_reproducoes()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE musica
     SET reproducoes_total = GREATEST(reproducoes_total - 1, 0)
   WHERE id_musica = OLD.id_musica;
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_decrementa_reproducoes
AFTER DELETE ON historico_reproducao
FOR EACH ROW
EXECUTE PROCEDURE trgfn_decrementa_reproducoes();

-- 2. AFTER UPDATE (caso a música do histórico seja alterada)
CREATE OR REPLACE FUNCTION trgfn_ajusta_reproducoes_update()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.id_musica <> OLD.id_musica THEN
     UPDATE musica
        SET reproducoes_total = GREATEST(reproducoes_total - 1, 0)
      WHERE id_musica = OLD.id_musica;

     UPDATE musica
        SET reproducoes_total = reproducoes_total + 1
      WHERE id_musica = NEW.id_musica;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_ajusta_reproducoes
AFTER UPDATE OF id_musica ON historico_reproducao
FOR EACH ROW
EXECUTE PROCEDURE trgfn_ajusta_reproducoes_update();


/* ---------------------------------------------------------------------
   3. Clonar playlist
------------------------------------------------------------------------ */
CREATE OR REPLACE FUNCTION fn_clone_playlist(
  p_playlist_id  INT,
  p_novo_user_id INT,
  p_novo_nome    TEXT
) RETURNS INT AS $$
DECLARE
  v_new_id INT;
BEGIN
  INSERT INTO playlist (nome, id_usuario, "createdAt", "updatedAt")
       VALUES (p_novo_nome, p_novo_user_id, NOW(), NOW())
  RETURNING id_playlist INTO v_new_id;

  INSERT INTO playlist_musica (id_playlist, id_musica, ordem)
  SELECT v_new_id, id_musica, ordem
    FROM playlist_musica
   WHERE id_playlist = p_playlist_id
ORDER BY ordem;

  RETURN v_new_id;
END;
$$ LANGUAGE plpgsql;


/* ---------------------------------------------------------------------
   4. Mover música dentro da playlist
------------------------------------------------------------------------ */
CREATE OR REPLACE FUNCTION fn_move_musica_playlist(
  p_playlist_id INT,
  p_musica_id   INT,
  p_nova_ordem  INT
) RETURNS VOID AS $$
DECLARE
  v_ordem_atual INT;
BEGIN
  SELECT ordem
    INTO v_ordem_atual
    FROM playlist_musica
   WHERE id_playlist = p_playlist_id
     AND id_musica   = p_musica_id;

  IF NOT FOUND OR v_ordem_atual = p_nova_ordem THEN
     RETURN;
  END IF;

  IF v_ordem_atual < p_nova_ordem THEN
     UPDATE playlist_musica
        SET ordem = ordem - 1
      WHERE id_playlist = p_playlist_id
        AND ordem BETWEEN v_ordem_atual + 1 AND p_nova_ordem;
  ELSE
     UPDATE playlist_musica
        SET ordem = ordem + 1
      WHERE id_playlist = p_playlist_id
        AND ordem BETWEEN p_nova_ordem AND v_ordem_atual - 1;
  END IF;

  UPDATE playlist_musica
     SET ordem = p_nova_ordem
   WHERE id_playlist = p_playlist_id
     AND id_musica   = p_musica_id;
END;
$$ LANGUAGE plpgsql;


/* ---------------------------------------------------------------------
   5. Limpar playlist
------------------------------------------------------------------------ */
CREATE OR REPLACE FUNCTION fn_clear_playlist(p_playlist_id INT)
RETURNS INT AS $$
DECLARE
  v_rows INT;
BEGIN
  DELETE FROM playlist_musica
   WHERE id_playlist = p_playlist_id;
  GET DIAGNOSTICS v_rows = ROW_COUNT;
  RETURN v_rows;
END;
$$ LANGUAGE plpgsql;


/* ---------------------------------------------------------------------
   6. Resumo rápido do usuário
------------------------------------------------------------------------ */
CREATE OR REPLACE FUNCTION fn_user_resumo(p_usuario_id INT)
RETURNS TABLE (
  total_playlists   INT,
  total_curtidas    INT,
  total_reproducoes BIGINT
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    (SELECT COUNT(*) FROM playlist             WHERE id_usuario = p_usuario_id),
    (SELECT COUNT(*) FROM curtidas             WHERE id_usuario = p_usuario_id),
    (SELECT COUNT(*) FROM historico_reproducao WHERE id_usuario = p_usuario_id);
END;
$$ LANGUAGE plpgsql;


/* =====================================================================
   =================================  VIEWS  ===========================
   ===================================================================== */
CREATE OR REPLACE VIEW vw_playlist_detalhes AS
SELECT p.id_playlist,
       p.nome               AS nome_playlist,
       u.nome               AS nome_usuario,
       COUNT(pm.id_musica)  AS qtd_musicas
  FROM playlist p
  JOIN usuario u        ON u.id_usuario = p.id_usuario
  LEFT JOIN playlist_musica pm
       ON pm.id_playlist = p.id_playlist
 GROUP BY p.id_playlist, p.nome, u.nome;

CREATE OR REPLACE VIEW vw_musica_completa AS
SELECT m.id_musica,
       m.titulo                   AS titulo_musica,
       m.genero,
       al.titulo                  AS titulo_album,
       ar.nome                    AS nome_artista,
       m.reproducoes_total,
       (SELECT COUNT(*)
          FROM curtidas c
         WHERE c.id_musica = m.id_musica) AS total_curtidas
  FROM musica  m
  LEFT JOIN album   al ON al.id_album   = m.id_album
  LEFT JOIN artista ar ON ar.id_artista = m.id_artista;

CREATE OR REPLACE VIEW vw_top10_mais_tocadas AS
SELECT m.id_musica,
       m.titulo,
       ar.nome              AS artista,
       m.reproducoes_total
  FROM musica  m
  JOIN artista ar ON ar.id_artista = m.id_artista
 ORDER BY m.reproducoes_total DESC
 LIMIT 10;


/* =====================================================================
   ===============================  ÍNDICES  ============================
   ===================================================================== */
CREATE INDEX IF NOT EXISTS idx_album_id_artista                ON album(id_artista);
CREATE INDEX IF NOT EXISTS idx_musica_id_artista               ON musica(id_artista);
CREATE INDEX IF NOT EXISTS idx_playlist_id_usuario             ON playlist(id_usuario);
CREATE INDEX IF NOT EXISTS idx_playlist_musica_id_musica       ON playlist_musica(id_musica);
CREATE INDEX IF NOT EXISTS idx_historico_reproducao_id_musica  ON historico_reproducao(id_musica);
CREATE INDEX IF NOT EXISTS idx_historico_reproducao_id_usuario ON historico_reproducao(id_usuario);
CREATE INDEX IF NOT EXISTS idx_curtidas_id_musica              ON curtidas(id_musica);
CREATE UNIQUE INDEX IF NOT EXISTS idx_usuario_email            ON usuario(email);


/* =====================================================================
   ===========================  TESTES OPCIONAIS  ======================
   (execute se quiser validar rapidamente; pode comentar se não precisar)
   ===================================================================== */


-- Clonar playlist 1 p/ user 2
SELECT fn_clone_playlist(1, 2, 'Clone da lista 1') AS nova_playlist;

-- Mover música 1 p/ posição 3 na nova playlist
SELECT fn_move_musica_playlist( (SELECT MAX(id_playlist) FROM playlist) , 1, 3 );

-- Limpar essa playlist
SELECT fn_clear_playlist( (SELECT MAX(id_playlist) FROM playlist) ) AS removidas;

-- Inserir e deletar reprodução p/ ver contadores
INSERT INTO historico_reproducao
       (id_usuario, id_musica, data_hora, "createdAt", "updatedAt")
VALUES (1, 1, NOW(), NOW(), NOW());

DELETE FROM historico_reproducao
 WHERE id_usuario = 1
   AND id_musica  = 1
 LIMIT 1;

SELECT id_musica, reproducoes_total FROM musica WHERE id_musica = 1;

