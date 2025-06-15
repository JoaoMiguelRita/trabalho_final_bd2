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
