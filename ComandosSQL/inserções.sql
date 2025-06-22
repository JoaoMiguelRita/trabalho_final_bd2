
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
