ALTER TABLE musica
ADD COLUMN IF NOT EXISTS reproducoes_total BIGINT DEFAULT 0;

//-----------Functions / Procedures-----------\\

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
    IF EXISTS (SELECT 1 FROM curtidas
                WHERE id_usuario = p_usuario_id
                  AND id_musica  = p_musica_id) THEN
        DELETE FROM curtidas
         WHERE id_usuario = p_usuario_id
           AND id_musica  = p_musica_id;
        RETURN 'Curtida removida';
    ELSE
        INSERT INTO curtidas (id_usuario, id_musica, data_curtida)
        VALUES (p_usuario_id, p_musica_id, NOW());
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

//--------------Trigger---------\\

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

//------------Views---------\\

--Resumo de cada playlist (dono + nº de músicas)
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

--“Ficha técnica” completa da música
CREATE OR REPLACE VIEW vw_musica_completa AS
SELECT m.id_musica,
       m.titulo                   AS titulo_musica,
       m.genero,
       al.titulo                  AS titulo_album,
       ar.nome                    AS nome_artista,
       m.reproducoes_total,
       (SELECT COUNT(*) FROM curtidas c
         WHERE c.id_musica = m.id_musica) AS total_curtidas
  FROM musica  m
  LEFT JOIN album   al ON al.id_album   = m.id_album
  LEFT JOIN artista ar ON ar.id_artista = m.id_artista;

--Top‑10 músicas mais tocadas na plataforma
CREATE OR REPLACE VIEW vw_top10_mais_tocadas AS
SELECT m.id_musica,
       m.titulo,
       ar.nome              AS artista,
       m.reproducoes_total
  FROM musica  m
  JOIN artista ar ON ar.id_artista = m.id_artista
 ORDER BY m.reproducoes_total DESC
 LIMIT 10;

//----------indices-------\\

CREATE INDEX IF NOT EXISTS idx_album_id_artista  ON album(id_artista);
CREATE INDEX IF NOT EXISTS idx_musica_id_artista ON musica(id_artista);
CREATE INDEX IF NOT EXISTS idx_playlist_id_usuario ON playlist(id_usuario);
CREATE INDEX IF NOT EXISTS idx_playlist_musica_id_musica ON playlist_musica(id_musica);
CREATE INDEX IF NOT EXISTS idx_historico_reproducao_id_musica ON historico_reproducao(id_musica);
CREATE INDEX IF NOT EXISTS idx_historico_reproducao_id_usuario ON historico_reproducao(id_usuario);
CREATE INDEX IF NOT EXISTS idx_curtidas_id_musica ON curtidas(id_musica);
CREATE UNIQUE INDEX IF NOT EXISTS idx_usuario_email ON usuario(email);

