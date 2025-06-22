--------------------------------------------------------------
-- 0. LIMPEZA (opcional) – Zere tabelas caso queira reexecutar
---------------------------------------------------------------
TRUNCATE historico_reproducao, curtidas, playlist_musica,
         playlist, musica, album, artista, usuario
         RESTART IDENTITY CASCADE;

---------------------------------------------------------------
-- 1. INSERÇÕES COMPLETAS 
---------------------------------------------------------------


-- usuario
INSERT INTO usuario
       ("nome", "email", "senha", "dt_nascimento", "tipo_conta", "createdAt", "updatedAt")
VALUES
('Alice Costa', 'alice@example.com', 'senha123', '1990-04-12', 'normal', NOW(), NOW()),
('Bruno Lima', 'bruno@example.com', 'senha123', '1985-06-23', 'premium', NOW(), NOW()),
('Carlos Dias', 'carlos@example.com', 'senha123', '2000-10-08', 'administrador', NOW(), NOW()),
('Daniela Rocha', 'daniela@example.com', 'senha123', '1995-02-17', 'normal', NOW(), NOW()),
('Eduardo Silva', 'eduardo@example.com', 'senha123', '1988-12-01', 'premium', NOW(), NOW()),
('Fernanda Luz', 'fernanda@example.com', 'senha123', '1992-07-09', 'normal', NOW(), NOW()),
('Gustavo Torres', 'gustavo@example.com', 'senha123', '1999-03-03', 'administrador', NOW(), NOW()),
('Helena Almeida', 'helena@example.com', 'senha123', '1997-08-20', 'premium', NOW(), NOW()),
('Igor Mendes', 'igor@example.com', 'senha123', '1994-11-15', 'normal', NOW(), NOW()),
('Juliana Farias', 'juliana@example.com', 'senha123', '2001-01-30', 'premium', NOW(), NOW());

-- artista
INSERT INTO artista
       ("nome", "nacionalidade", "createdAt", "updatedAt")
VALUES
('Banda Alpha', 'Brasil', NOW(), NOW()),
('DJ Max', 'EUA', NOW(), NOW()),
('Luna Melo', 'Brasil', NOW(), NOW()),
('The Sunsetters', 'Inglaterra', NOW(), NOW()),
('Sophie Blue', 'Canadá', NOW(), NOW()),
('Grupo Raiz', 'Brasil', NOW(), NOW()),
('Eletronic Pulse', 'Alemanha', NOW(), NOW()),
('João Pires', 'Portugal', NOW(), NOW()),
('The Rockets', 'EUA', NOW(), NOW()),
('Marina Sky', 'Austrália', NOW(), NOW());

-- album
INSERT INTO album
       ("titulo", "ano_lancamento", "id_artista", "createdAt", "updatedAt")
VALUES
('Aurora Boreal', 2020, 1, NOW(), NOW()),
('Batidas Urbanas', 2018, 2, NOW(), NOW()),
('Caminhos', 2021, 3, NOW(), NOW()),
('Golden Times', 2015, 4, NOW(), NOW()),
('Blue Horizon', 2022, 5, NOW(), NOW()),
('Raízes', 2019, 6, NOW(), NOW()),
('Frequência Total', 2020, 7, NOW(), NOW()),
('Canções do Sul', 2021, 8, NOW(), NOW()),
('Rockets Reloaded', 2017, 9, NOW(), NOW()),
('Sky High', 2023, 10, NOW(), NOW());

-- musica
INSERT INTO musica
       ("titulo", "genero", "id_album", "id_artista", "createdAt", "updatedAt")
VALUES
('Nas Estrelas', 'Pop', 1, 1, NOW(), NOW()),
('Ritmo da Rua', 'Eletrônica', 2, 2, NOW(), NOW()),
('Horizonte Aberto', 'MPB', 3, 3, NOW(), NOW()),
('Golden Days', 'Rock', 4, 4, NOW(), NOW()),
('Ocean Deep', 'Indie', 5, 5, NOW(), NOW()),
('Meu Sertão', 'Sertanejo', 6, 6, NOW(), NOW()),
('Sintonia', 'Eletrônica', 7, 7, NOW(), NOW()),
('Fado Novo', 'Fado', 8, 8, NOW(), NOW()),
('Rocket Fuel', 'Rock', 9, 9, NOW(), NOW()),
('Voar Mais Alto', 'Pop', 10, 10, NOW(), NOW());

-- playlist
INSERT INTO playlist
       ("nome", "id_usuario", "createdAt", "updatedAt")
VALUES
('Treino Pesado', 1, NOW(), NOW()),
('Relaxamento', 2, NOW(), NOW()),
('Hits 2020', 3, NOW(), NOW()),
('Favoritas da Dani', 4, NOW(), NOW()),
('MPB Top', 5, NOW(), NOW()),
('Eletrônicas', 6, NOW(), NOW()),
('Rock Clássico', 7, NOW(), NOW()),
('Só Sertanejo', 8, NOW(), NOW()),
('Vibe Indie', 9, NOW(), NOW()),
('Músicas de Viagem', 10, NOW(), NOW());

-- playlist_musica
INSERT INTO playlist_musica
       ("id_playlist", "id_musica", "ordem", "createdAt", "updatedAt")
VALUES
(1, 2, 1, NOW(), NOW()),
(1, 7, 2, NOW(), NOW()),
(2, 5, 1, NOW(), NOW()),
(2, 10, 2, NOW(), NOW()),
(3, 1, 1, NOW(), NOW()),
(3, 2, 2, NOW(), NOW()),
(4, 3, 1, NOW(), NOW()),
(4, 6, 2, NOW(), NOW()),
(5, 3, 1, NOW(), NOW()),
(6, 7, 1, NOW(), NOW()),
(7, 4, 1, NOW(), NOW()),
(7, 9, 2, NOW(), NOW()),
(8, 6, 1, NOW(), NOW()),
(9, 5, 1, NOW(), NOW()),
(10, 1, 1, NOW(), NOW()),
(10, 10, 2, NOW(), NOW());

-- historico_reproducao
INSERT INTO historico_reproducao
       ("id_usuario", "id_musica", "data_hora", "createdAt", "updatedAt")
VALUES
(1, 2, '2025-06-10 08:30:00', NOW(), NOW()),
(1, 7, '2025-06-10 08:35:00', NOW(), NOW()),
(2, 5, '2025-06-09 22:00:00', NOW(), NOW()),
(3, 1, '2025-06-08 19:20:00', NOW(), NOW()),
(4, 3, '2025-06-07 15:45:00', NOW(), NOW()),
(5, 6, '2025-06-06 18:00:00', NOW(), NOW()),
(6, 7, '2025-06-05 21:15:00', NOW(), NOW()),
(7, 4, '2025-06-05 16:50:00', NOW(), NOW()),
(8, 6, '2025-06-04 14:30:00', NOW(), NOW()),
(9, 5, '2025-06-03 20:00:00', NOW(), NOW());

-- curtidas
INSERT INTO curtidas
       ("id_usuario", "id_musica", "data_curtida", "createdAt", "updatedAt")
VALUES
(1, 2, '2025-06-10 09:00:00', NOW(), NOW()),
(1, 7, '2025-06-10 09:05:00', NOW(), NOW()),
(2, 5, '2025-06-09 22:10:00', NOW(), NOW()),
(3, 1, '2025-06-08 19:30:00', NOW(), NOW()),
(4, 3, '2025-06-07 15:50:00', NOW(), NOW()),
(5, 6, '2025-06-06 18:05:00', NOW(), NOW()),
(6, 7, '2025-06-05 21:20:00', NOW(), NOW()),
(7, 4, '2025-06-05 16:55:00', NOW(), NOW()),
(8, 6, '2025-06-04 14:35:00', NOW(), NOW()),
(9, 5, '2025-06-03 20:05:00', NOW(), NOW());

---------------------------------------------------------------
-- 0.B ALTER TABLE – extensão de schema criado pelo Sequelize
--     (Mostra que podemos evoluir o modelo depois da migration)
---------------------------------------------------------------
-- Verificar se a coluna já existe
SELECT column_name, data_type, column_default
  FROM information_schema.columns
 WHERE table_name = 'musica'
   AND column_name = 'reproducoes_total';

-- Adicionar coluna caso não exista
ALTER TABLE musica
ADD COLUMN IF NOT EXISTS reproducoes_total BIGINT DEFAULT 0;

-- Confirmar
SELECT column_name, data_type, column_default
  FROM information_schema.columns
 WHERE table_name = 'musica'
   AND column_name = 'reproducoes_total';



---------------------------------------------------------------
-- 1.  fn_add_musica_playlist  – adiciona ao final
---------------------------------------------------------------
-- BEFORE
SELECT id_playlist, id_musica, ordem
  FROM playlist_musica
 WHERE id_playlist = 1
 ORDER BY ordem;

-- CALL
SELECT fn_add_musica_playlist(1, 3);   -- adiciona música 3

-- AFTER
SELECT id_playlist, id_musica, ordem
  FROM playlist_musica
 WHERE id_playlist = 1
 ORDER BY ordem;


---------------------------------------------------------------
-- 2.  fn_toggle_curtida  – alterna like
---------------------------------------------------------------
-- BEFORE
SELECT *
  FROM curtidas
 WHERE id_usuario = 1 AND id_musica = 3;

-- CALL 1  (insere)
SELECT fn_toggle_curtida(1, 3);

-- AFTER 1
SELECT *
  FROM curtidas
 WHERE id_usuario = 1 AND id_musica = 3;

-- CALL 2  (remove)
SELECT fn_toggle_curtida(1, 3);

-- AFTER 2
SELECT *
  FROM curtidas
 WHERE id_usuario = 1 AND id_musica = 3;

---------------------------------------------------------------
-- 3.  fn_top_musicas_usuario  – ranking pessoal
---------------------------------------------------------------
SELECT * FROM fn_top_musicas_usuario(1, 5);

---------------------------------------------------------------
-- 4.  TRIGGERS DE REPRODUÇÃO
---------------------------------------------------------------
/* 4.1 Incrementa após INSERT */
SELECT reproducoes_total FROM musica WHERE id_musica = 1;

INSERT INTO historico_reproducao (id_usuario, id_musica, data_hora, "createdAt", "updatedAt")
VALUES (1, 1, NOW(), NOW(), NOW());

SELECT reproducoes_total FROM musica WHERE id_musica = 1;

/* 4.2 Decrementa após DELETE */
DELETE FROM historico_reproducao
 WHERE ctid IN (SELECT ctid FROM historico_reproducao WHERE id_usuario = 1 AND id_musica = 1 LIMIT 1)
 RETURNING *;

SELECT reproducoes_total FROM musica WHERE id_musica = 1;

/* 4.3 Ajusta após UPDATE id_musica */
-- suponha id_historico = (SELECT id_historico FROM historico_reproducao WHERE id_usuario = 1 LIMIT 1);
-- UPDATE historico_reproducao SET id_musica = 2 WHERE id_historico = ...;

---------------------------------------------------------------
-- 5.  fn_clone_playlist  – cópia completa
---------------------------------------------------------------
SELECT COUNT(*) FROM playlist WHERE id_usuario = 2;  -- antes
SELECT fn_clone_playlist(1, 2, 'Clone Playlist 1') AS nova_playlist_id;
SELECT * FROM playlist WHERE id_usuario = 2 ORDER BY id_playlist DESC LIMIT 1;
SELECT * FROM playlist_musica WHERE id_playlist = (SELECT MAX(id_playlist) FROM playlist WHERE id_usuario = 2);

---------------------------------------------------------------
-- 6.  fn_move_musica_playlist  – reorder
---------------------------------------------------------------
SELECT id_musica, ordem FROM playlist_musica WHERE id_playlist = 1 ORDER BY ordem;
SELECT fn_move_musica_playlist(1, 2, 1);
SELECT id_musica, ordem FROM playlist_musica WHERE id_playlist = 1 ORDER BY ordem;

---------------------------------------------------------------
-- 7.  fn_clear_playlist  – remove todas músicas
---------------------------------------------------------------
SELECT COUNT(*) FROM playlist_musica WHERE id_playlist = 10;
SELECT fn_clear_playlist(10) AS removidas;
SELECT COUNT(*) FROM playlist_musica WHERE id_playlist = 10;

---------------------------------------------------------------
-- 8.  fn_user_resumo  – estatísticas do usuário
---------------------------------------------------------------
SELECT * FROM fn_user_resumo(1);

---------------------------------------------------------------
-- 9. VIEWS
---------------------------------------------------------------
SELECT * FROM vw_playlist_detalhes ORDER BY id_playlist;
SELECT * FROM vw_musica_completa  ORDER BY id_musica LIMIT 10;
SELECT * FROM vw_top10_mais_tocadas;
