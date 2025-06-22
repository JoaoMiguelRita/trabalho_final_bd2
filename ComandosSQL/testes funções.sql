-- 1. Teste: add música à playlist
SELECT fn_add_musica_playlist(1, 1);
SELECT * FROM playlist_musica WHERE id_playlist = 1 ORDER BY ordem;

-- 2. Teste: toggle curtida
SELECT fn_toggle_curtida(1, 1);   -- adiciona
SELECT fn_toggle_curtida(1, 1);   -- remove
SELECT * FROM curtidas WHERE id_usuario = 1 AND id_musica = 1;

-- 3. Teste: top músicas do usuário
SELECT * FROM fn_top_musicas_usuario(1, 5);

-- 4. Teste: trigger de reproduções
INSERT INTO historico_reproducao
       (id_usuario, id_musica, data_hora, "createdAt", "updatedAt")
VALUES (1, 1, NOW(), NOW(), NOW());

SELECT id_musica, reproducoes_total
  FROM musica
 WHERE id_musica = 1;

-- 5. Teste: views
SELECT * FROM vw_playlist_detalhes   LIMIT 5;
SELECT * FROM vw_musica_completa     LIMIT 5;
SELECT * FROM vw_top10_mais_tocadas;