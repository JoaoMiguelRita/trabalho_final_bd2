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
