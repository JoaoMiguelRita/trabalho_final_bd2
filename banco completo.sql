
CREATE TABLE usuario (
    id_usuario INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(100) NOT NULL,
    dt_nascimento DATE NOT NULL,
    tipo_conta char (1)
);

CREATE TABLE artista (
    id_artista INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    nacionalidade VARCHAR(50)
);


CREATE TABLE album (
    id_album INT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    ano_lancamento INT,
    id_artista INT,
    FOREIGN KEY (id_artista) REFERENCES Artista(id_artista)
);

CREATE TABLE musica (
    id_musica INT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    genero VARCHAR(50),
    id_album INT,
    id_artista INT,
    FOREIGN KEY (id_album) REFERENCES Album(id_album),
    FOREIGN KEY (id_artista) REFERENCES Artista(id_artista)
);

CREATE TABLE playlist (
    id_playlist INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE playlist_musica (
    id_playlist INT,
    id_musica INT,
    ordem INT,
    PRIMARY KEY (id_playlist, id_musica),
    FOREIGN KEY (id_playlist) REFERENCES Playlist(id_playlist),
    FOREIGN KEY (id_musica) REFERENCES Musica(id_musica)
);

CREATE TABLE historico_reproducao (
    id_usuario INT,
    id_musica INT,
    data_hora TIMESTAMP,
    PRIMARY KEY (id_usuario, id_musica, data_hora),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_musica) REFERENCES Musica(id_musica)
);

CREATE TABLE curtidas (
    id_usuario INT,
    id_musica INT,
    data_curtida TIMESTAMP,
    PRIMARY KEY (id_usuario, id_musica),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_musica) REFERENCES Musica(id_musica)
);

-- usuario
INSERT INTO usuario (id_usuario, nome, email, senha, dt_nascimento, tipo_conta) VALUES
(1, 'Alice Costa', 'alice@example.com', 'senha123', '1990-04-12', 'P'),
(2, 'Bruno Lima', 'bruno@example.com', 'senha123', '1985-06-23', 'G'),
(3, 'Carlos Dias', 'carlos@example.com', 'senha123', '2000-10-08', 'P'),
(4, 'Daniela Rocha', 'daniela@example.com', 'senha123', '1995-02-17', 'G'),
(5, 'Eduardo Silva', 'eduardo@example.com', 'senha123', '1988-12-01', 'P'),
(6, 'Fernanda Luz', 'fernanda@example.com', 'senha123', '1992-07-09', 'P'),
(7, 'Gustavo Torres', 'gustavo@example.com', 'senha123', '1999-03-03', 'G'),
(8, 'Helena Almeida', 'helena@example.com', 'senha123', '1997-08-20', 'P'),
(9, 'Igor Mendes', 'igor@example.com', 'senha123', '1994-11-15', 'G'),
(10, 'Juliana Farias', 'juliana@example.com', 'senha123', '2001-01-30', 'P');

-- artista
INSERT INTO artista (id_artista, nome, nacionalidade) VALUES
(1, 'Banda Alpha', 'Brasil'),
(2, 'DJ Max', 'EUA'),
(3, 'Luna Melo', 'Brasil'),
(4, 'The Sunsetters', 'Inglaterra'),
(5, 'Sophie Blue', 'Canadá'),
(6, 'Grupo Raiz', 'Brasil'),
(7, 'Eletronic Pulse', 'Alemanha'),
(8, 'João Pires', 'Portugal'),
(9, 'The Rockets', 'EUA'),
(10, 'Marina Sky', 'Austrália');

-- album
INSERT INTO album (id_album, titulo, ano_lancamento, id_artista) VALUES
(1, 'Aurora Boreal', 2020, 1),
(2, 'Batidas Urbanas', 2018, 2),
(3, 'Caminhos', 2021, 3),
(4, 'Golden Times', 2015, 4),
(5, 'Blue Horizon', 2022, 5),
(6, 'Raízes', 2019, 6),
(7, 'Frequência Total', 2020, 7),
(8, 'Canções do Sul', 2021, 8),
(9, 'Rockets Reloaded', 2017, 9),
(10, 'Sky High', 2023, 10);

-- musica
INSERT INTO musica (id_musica, titulo, genero, id_album, id_artista) VALUES
(1, 'Nas Estrelas', 'Pop', 1, 1),
(2, 'Ritmo da Rua', 'Eletrônica', 2, 2),
(3, 'Horizonte Aberto', 'MPB', 3, 3),
(4, 'Golden Days', 'Rock', 4, 4),
(5, 'Ocean Deep', 'Indie', 5, 5),
(6, 'Meu Sertão', 'Sertanejo', 6, 6),
(7, 'Sintonia', 'Eletrônica', 7, 7),
(8, 'Fado Novo', 'Fado', 8, 8),
(9, 'Rocket Fuel', 'Rock', 9, 9),
(10, 'Voar Mais Alto', 'Pop', 10, 10);

-- playlist
INSERT INTO playlist (id_playlist, nome, id_usuario) VALUES
(1, 'Treino Pesado', 1),
(2, 'Relaxamento', 2),
(3, 'Hits 2020', 3),
(4, 'Favoritas da Dani', 4),
(5, 'MPB Top', 5),
(6, 'Eletrônicas', 6),
(7, 'Rock Clássico', 7),
(8, 'Só Sertanejo', 8),
(9, 'Vibe Indie', 9),
(10, 'Músicas de Viagem', 10);

-- playlist_musica
INSERT INTO playlist_musica (id_playlist, id_musica, ordem) VALUES
(1, 2, 1),
(1, 7, 2),
(2, 5, 1),
(2, 10, 2),
(3, 1, 1),
(3, 2, 2),
(4, 3, 1),
(4, 6, 2),
(5, 3, 1),
(6, 7, 1),
(7, 4, 1),
(7, 9, 2),
(8, 6, 1),
(9, 5, 1),
(10, 1, 1),
(10, 10, 2);

-- historico_reproducao
INSERT INTO historico_reproducao (id_usuario, id_musica, data_hora) VALUES
(1, 2, '2025-06-10 08:30:00'),
(1, 7, '2025-06-10 08:35:00'),
(2, 5, '2025-06-09 22:00:00'),
(3, 1, '2025-06-08 19:20:00'),
(4, 3, '2025-06-07 15:45:00'),
(5, 6, '2025-06-06 18:00:00'),
(6, 7, '2025-06-05 21:15:00'),
(7, 4, '2025-06-05 16:50:00'),
(8, 6, '2025-06-04 14:30:00'),
(9, 5, '2025-06-03 20:00:00');

-- curtidas
INSERT INTO curtidas (id_usuario, id_musica, data_curtida) VALUES
(1, 2, '2025-06-10 09:00:00'),
(1, 7, '2025-06-10 09:05:00'),
(2, 5, '2025-06-09 22:10:00'),
(3, 1, '2025-06-08 19:30:00'),
(4, 3, '2025-06-07 15:50:00'),
(5, 6, '2025-06-06 18:05:00'),
(6, 7, '2025-06-05 21:20:00'),
(7, 4, '2025-06-05 16:55:00'),
(8, 6, '2025-06-04 14:35:00'),
(9, 5, '2025-06-03 20:05:00');

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


