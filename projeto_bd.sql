-- DDL: Criação das Tabelas

CREATE TABLE "User" (
    id_user SERIAL PRIMARY KEY,
    img_user VARCHAR(255),
    name VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    gender VARCHAR(50),
    birth DATE,
    is_active BOOLEAN DEFAULT TRUE,
    email VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE Artist (
    id_artist SERIAL PRIMARY KEY,
    id_user INTEGER UNIQUE NOT NULL,
    pseudonym VARCHAR(255) UNIQUE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    img_artist VARCHAR(255),
    FOREIGN KEY (id_user) REFERENCES "User"(id_user)
);

CREATE TABLE User_follows_Artist (
    id_artist INTEGER NOT NULL,
    id_user INTEGER NOT NULL,
    start_date DATE NOT NULL,
    PRIMARY KEY (id_artist, id_user),
    FOREIGN KEY (id_artist) REFERENCES Artist(id_artist),
    FOREIGN KEY (id_user) REFERENCES "User"(id_user)
);

CREATE TABLE User_is_Artist (
    id_artist INTEGER NOT NULL,
    id_user INTEGER NOT NULL,
    start_date DATE NOT NULL,
    PRIMARY KEY (id_artist, id_user),
    FOREIGN KEY (id_artist) REFERENCES Artist(id_artist),
    FOREIGN KEY (id_user) REFERENCES "User"(id_user)
);


CREATE TABLE Playlist (
    id_playlist SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
    id_user INTEGER NOT NULL,
    creation_date DATE NOT NULL DEFAULT CURRENT_DATE,
    total_tracks INTEGER DEFAULT 0,
    duration_seconds INTEGER DEFAULT 0,
    img_playlist VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_user) REFERENCES "User"(id_user)
);

CREATE TABLE User_Has_Playlist (
    id_playlist INTEGER NOT NULL,
    id_user INTEGER NOT NULL,
    followed_date DATE NOT NULL,
    PRIMARY KEY (id_playlist, id_user),
    FOREIGN KEY (id_playlist) REFERENCES Playlist(id_playlist),
    FOREIGN KEY (id_user) REFERENCES "User"(id_user)
);

CREATE TABLE Album (
    id_album SERIAL PRIMARY KEY,
    id_artist INTEGER NOT NULL,
    title VARCHAR(255) NOT NULL,
    release_date DATE,
    img VARCHAR(255),
    total_tracks INTEGER DEFAULT 0,
    duration_seconds INTEGER DEFAULT 0,
    FOREIGN KEY (id_artist) REFERENCES Artist(id_artist)
);

CREATE TABLE Music (
    id_music SERIAL PRIMARY KEY,
    id_album INTEGER,
    name VARCHAR(255) NOT NULL,
    img VARCHAR(255),
    release_date DATE,
    duration_seconds INTEGER,
    FOREIGN KEY (id_album) REFERENCES Album(id_album)
);

CREATE TABLE Genre (
    name VARCHAR(255) PRIMARY KEY,
    parent_name_genre VARCHAR(255),
    FOREIGN KEY (parent_name_genre) REFERENCES Genre(name)
);

CREATE TABLE Music_has_Genre (
    id_music INTEGER NOT NULL,
    name_genre VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_music, name_genre),
    FOREIGN KEY (id_music) REFERENCES Music(id_music),
    FOREIGN KEY (name_genre) REFERENCES Genre(name)
);

CREATE TABLE Playlist_has_Music (
    id_music INTEGER NOT NULL,
    id_playlist INTEGER NOT NULL,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_music, id_playlist),
    FOREIGN KEY (id_music) REFERENCES Music(id_music),
    FOREIGN KEY (id_playlist) REFERENCES Playlist(id_playlist)
);

CREATE TABLE Artist_Ows_Music (
    id_artist INTEGER NOT NULL,
    id_music INTEGER NOT NULL,
    PRIMARY KEY (id_artist, id_music),
    FOREIGN KEY (id_artist) REFERENCES Artist(id_artist),
    FOREIGN KEY (id_music) REFERENCES Music(id_music)
);

-- DML: Inserção de Dados de Teste (pelo menos 10 registros em cada tabela principal)

-- Tabela User
INSERT INTO "User" (img_user, name, password, gender, birth, is_active, email) VALUES
('img_user1.jpg', 'Alice Silva', 'senha123', 'Feminino', '1990-05-15', TRUE, 'alice.silva@email.com'),
('img_user2.jpg', 'Bruno Costa', 'senha456', 'Masculino', '1988-11-20', TRUE, 'bruno.costa@email.com'),
('img_user3.jpg', 'Carla Dias', 'senha789', 'Feminino', '1995-03-10', TRUE, 'carla.dias@email.com'),
('img_user4.jpg', 'Daniel Souza', 'senhaabc', 'Masculino', '1992-07-25', TRUE, 'daniel.souza@email.com'),
('img_user5.jpg', 'Eduarda Lima', 'senhaxpt', 'Feminino', '1998-01-01', TRUE, 'eduarda.lima@email.com'),
('img_user6.jpg', 'Fernando Santos', 'senhalmn', 'Masculino', '1985-09-03', TRUE, 'fernando.santos@email.com'),
('img_user7.jpg', 'Gabriela Pereira', 'senhawww', 'Feminino', '1993-12-18', TRUE, 'gabriela.pereira@email.com'),
('img_user8.jpg', 'Henrique Oliveira', 'senhazzz', 'Masculino', '1991-04-22', TRUE, 'henrique.oliveira@email.com'),
('img_user9.jpg', 'Isabela Rodrigues', 'senhaqqq', 'Feminino', '1997-06-07', TRUE, 'isabela.rodrigues@email.com'),
('img_user10.jpg', 'João Almeida', 'senhaert', 'Masculino', '1987-02-14', TRUE, 'joao.almeida@email.com'),
('img_user11.jpg', 'Laura Martins', 'senhacvb', 'Feminino', '1994-08-29', TRUE, 'laura.martins@email.com'),
('img_user12.jpg', 'Marcos Nunes', 'senhaasd', 'Masculino', '1989-10-05', TRUE, 'marcos.nunes@email.com');


-- Tabela Artist (id_user deve existir na tabela User)
INSERT INTO Artist (id_user, pseudonym, is_active, img_artist) VALUES
(1, 'SingerAlice', TRUE, 'img_artist_alice.jpg'),
(2, 'GuitarBruno', TRUE, 'img_artist_bruno.jpg'),
(3, 'CarlaDancer', TRUE, 'img_artist_carla.jpg'),
(4, 'DJDaniel', TRUE, 'img_artist_daniel.jpg'),
(5, 'EduardaVoice', TRUE, 'img_artist_eduarda.jpg'),
(6, 'FernaMix', TRUE, 'img_artist_fernando.jpg'),
(7, 'GabiBeats', TRUE, 'img_artist_gabriela.jpg'),
(8, 'HenryKeys', TRUE, 'img_artist_henrique.jpg'),
(9, 'BellaRythm', TRUE, 'img_artist_isabela.jpg'),
(10, 'JAZZio', TRUE, 'img_artist_joao.jpg');


-- Tabela User_follows_Artist
INSERT INTO User_follows_Artist (id_artist, id_user, start_date) VALUES
(1, 2, '2023-01-10'),
(2, 1, '2023-01-15'),
(3, 4, '2023-02-01'),
(4, 3, '2023-02-05'),
(5, 6, '2023-03-10'),
(6, 5, '2023-03-15'),
(7, 8, '2023-04-01'),
(8, 7, '2023-04-05'),
(9, 10, '2023-05-10'),
(10, 9, '2023-05-15');

-- Tabela User_is_Artist
INSERT INTO User_is_Artist (id_artist, id_user, start_date) VALUES
(1, 1, '2022-01-01'),
(2, 2, '2022-02-01'),
(3, 3, '2022-03-01'),
(4, 4, '2022-04-01'),
(5, 5, '2022-05-01'),
(6, 6, '2022-06-01'),
(7, 7, '2022-07-01'),
(8, 8, '2022-08-01'),
(9, 9, '2022-09-01'),
(10, 10, '2022-10-01');


-- Tabela Playlist
INSERT INTO Playlist (id_user, name, creation_date, total_tracks, duration_seconds, img_playlist, is_active) VALUES
(1, 'Juventina', '2024-01-01', 15, 3600, 'img_playlist_1.jpg', TRUE),
(2, 'Tamanca', '2024-01-05', 10, 2400, 'img_playlist_2.jpg', TRUE),
(3, 'Tô presa nessa cidade', '2024-01-10', 20, 4800, 'img_playlist_3.jpg', TRUE),
(4, 'Lapaliga roubou meu malido', '2024-01-15', 8, 1920, 'img_playlist_4.jpg', TRUE),
(5, 'Burro não é um cavalo dirigindo', '2024-01-20', 12, 2880, 'img_playlist_5.jpg', TRUE),
(6, 'Filma ela em nome de Jesus', '2024-01-25', 18, 4320, 'img_playlist_6.jpg', TRUE),
(7, 'Ai é assalto', '2024-02-01', 7, 1680, 'img_playlist_7.jpg', TRUE),
(8, 'É não, sou eu que vim te matar', '2024-02-05', 25, 6000, 'img_playlist_8.jpg', TRUE),
(9,'Já não tava bom', '2024-02-10', 14, 3360, 'img_playlist_9.jpg', TRUE),
(10, 'Geladeira Tsunami', '2024-02-15', 9, 2160, 'img_playlist_10.jpg', TRUE);


-- Tabela User_Has_Playlist
INSERT INTO User_Has_Playlist (id_playlist, id_user, followed_date) VALUES
(1, 2, '2024-03-01'),
(2, 1, '2024-03-05'),
(3, 4, '2024-03-10'),
(4, 3, '2024-03-15'),
(5, 6, '2024-03-20'),
(6, 5, '2024-03-25'),
(7, 8, '2024-04-01'),
(8, 7, '2024-04-05'),
(9, 10, '2024-04-10'),
(10, 9, '2024-04-15');


-- Tabela Album
INSERT INTO Album (id_artist, title, release_date, img, total_tracks, duration_seconds) VALUES
(1, 'The First Album', '2023-01-01', 'img_album_1.jpg', 10, 2400),
(2, 'Guitar Masterpieces', '2023-02-01', 'img_album_2.jpg', 8, 1920),
(3, 'Dance Moves', '2023-03-01', 'img_album_3.jpg', 12, 2880),
(4, 'Electronic Beats', '2023-04-01', 'img_album_4.jpg', 9, 2160),
(5, 'Vocal Journey', '2023-05-01', 'img_album_5.jpg', 11, 2640),
(6, 'Remix Collection', '2023-06-01', 'img_album_6.jpg', 15, 3600),
(7, 'Rhythmic Vibes', '2023-07-01', 'img_album_7.jpg', 7, 1680),
(8, 'Piano Delights', '2023-08-01', 'img_album_8.jpg', 13, 3120),
(9, 'Groovy Sounds', '2023-09-01', 'img_album_9.jpg', 10, 2400),
(10, 'Jazz Fusion', '2023-10-01', 'img_album_10.jpg', 8, 1920);


-- Tabela Music
INSERT INTO Music (id_album, name, img, release_date, duration_seconds) VALUES
(1, 'Song A1', 'img_music_a1.jpg', '2023-01-01', 240),
(1, 'Song A2', 'img_music_a2.jpg', '2023-01-01', 250),
(2, 'Song B1', 'img_music_b1.jpg', '2023-02-01', 200),
(2, 'Song B2', 'img_music_b2.jpg', '2023-02-01', 210),
(3, 'Song C1', 'img_music_c1.jpg', '2023-03-01', 300),
(3, 'Song C2', 'img_music_c2.jpg', '2023-03-01', 280),
(4, 'Song D1', 'img_music_d1.jpg', '2023-04-01', 220),
(4, 'Song D2', 'img_music_d2.jpg', '2023-04-01', 230),
(5, 'Song E1', 'img_music_e1.jpg', '2023-05-01', 270),
(5, 'Song E2', 'img_music_e2.jpg', '2023-05-01', 260),
(6, 'Song F1', 'img_music_f1.jpg', '2023-06-01', 310),
(7, 'Song G1', 'img_music_g1.jpg', '2023-07-01', 190);


-- Tabela Genre
INSERT INTO Genre (name, parent_name_genre) VALUES
('Rock', NULL),
('Pop', NULL),
('Jazz', NULL),
('Electronic', NULL),
('Hip Hop', NULL),
('Classical', NULL),
('Alternative Rock', 'Rock'),
('Pop Rock', 'Pop'),
('Smooth Jazz', 'Jazz'),
('House', 'Electronic'),
('Trap', 'Hip Hop');

-- Tabela Music_has_Genre
INSERT INTO Music_has_Genre (id_music, name_genre) VALUES
(1, 'Rock'),
(1, 'Alternative Rock'),
(2, 'Rock'),
(3, 'Pop'),
(3, 'Pop Rock'),
(4, 'Pop'),
(5, 'Electronic'),
(5, 'House'),
(6, 'Electronic'),
(7, 'Hip Hop'),
(7, 'Trap'),
(8, 'Hip Hop'),
(9, 'Jazz'),
(9, 'Smooth Jazz'),
(10, 'Jazz');

-- Tabela Playlist_has_Music
INSERT INTO Playlist_has_Music (id_music, id_playlist, added_at) VALUES
(1, 1, '2024-03-01 10:00:00'),
(2, 1, '2024-03-01 10:05:00'),
(3, 2, '2024-03-02 11:00:00'),
(4, 2, '2024-03-02 11:05:00'),
(5, 3, '2024-03-03 12:00:00'),
(6, 3, '2024-03-03 12:05:00'),
(7, 4, '2024-03-04 13:00:00'),
(8, 4, '2024-03-04 13:05:00'),
(9, 5, '2024-03-05 14:00:00'),
(10, 5, '2024-03-05 14:05:00'),
(1, 6, '2024-03-06 15:00:00'),
(2, 7, '2024-03-07 16:00:00'),
(3, 8, '2024-03-08 17:00:00'),
(4, 9, '2024-03-09 18:00:00'),
(5, 10, '2024-03-10 19:00:00');

-- Tabela Artist_Ows_Music
INSERT INTO Artist_Ows_Music (id_artist, id_music) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 5),
(3, 6),
(4, 7),
(4, 8),
(5, 9),
(5, 10);


-- Consultas SQL Significativas

-- Consulta 1: Retorna o nome de todos os usuários e os pseudônimos dos artistas que eles seguem.
-- Esta consulta demonstra um JOIN entre as tabelas User, User_follows_Artist e Artist,
-- mostrando como relacionar usuários com artistas que eles seguem.
SELECT
    U.name AS user_name,
    A.pseudonym AS artist_pseudonym
FROM
    "User" AS U
JOIN
    User_follows_Artist AS UFA ON U.id_user = UFA.id_user
JOIN
    Artist AS A ON UFA.id_artist = A.id_artist;

-- Consulta 2: Lista todas as músicas em uma playlist específica, incluindo o nome do álbum (se houver).
-- Esta consulta envolve JOINs entre Playlist, Playlist_has_Music, Music e Album,
-- agregando informações sobre músicas e seus álbuns dentro de uma playlist.
-- Substitua '1' pelo ID da playlist desejada.
SELECT
    P.name AS playlist_name,
    M.name AS music_name,
    AL.title AS album_title,
    PHM.added_at
FROM
    Playlist AS P
JOIN
    Playlist_has_Music AS PHM ON P.id_playlist = PHM.id_playlist
JOIN
    Music AS M ON PHM.id_music = M.id_music
LEFT JOIN
    Album AS AL ON M.id_album = AL.id_album
WHERE
    P.id_playlist = 1; -- Exemplo: playlist com ID 1

-- Consulta 3: Mostra todos os artistas e o número de álbuns que cada um lançou.
-- Esta consulta usa GROUP BY e COUNT para agregar dados por artista,
-- fornecendo uma visão geral da produtividade de cada artista em termos de álbuns.
SELECT
    A.pseudonym AS artist_pseudonym,
    COUNT(AL.id_album) AS number_of_albums
FROM
    Artist AS A
LEFT JOIN
    Album AS AL ON A.id_artist = AL.id_artist
GROUP BY
    A.pseudonym
ORDER BY
    number_of_albums DESC;

-- Consulta 4: Encontra todos os usuários que também são artistas.
-- Demonstra um JOIN simples para identificar usuários com múltiplos papéis.
SELECT
    U.name AS user_name,
    A.pseudonym AS artist_pseudonym
FROM
    "User" AS U
JOIN
    User_is_Artist AS UIA ON U.id_user = UIA.id_user
JOIN
    Artist AS A ON UIA.id_artist = A.id_artist;

-- Consulta 5: Lista as músicas de um gênero específico e os artistas que as possuem.
-- Esta consulta utiliza múltiplos JOINs e um filtro WHERE para buscar informações detalhadas sobre músicas de um gênero,
-- incluindo os artistas relacionados a essas músicas. Substitua 'Rock' pelo nome do gênero desejado.
SELECT
    M.name AS music_name,
    G.name AS genre_name,
    A.pseudonym AS artist_pseudonym
FROM
    Music AS M
JOIN
    Music_has_Genre AS MHG ON M.id_music = MHG.id_music
JOIN
    Genre AS G ON MHG.name_genre = G.name
LEFT JOIN
    Artist_Ows_Music AS AOM ON M.id_music = AOM.id_music
LEFT JOIN
    Artist AS A ON AOM.id_artist = A.id_artist
WHERE
    G.name = 'Rock'; -- Exemplo: músicas do gênero 'Rock'

-- Consulta 6: Obtém o nome das playlists que um usuário específico segue, incluindo a data em que começou a seguir.
-- Esta consulta demonstra como rastrear as playlists que um usuário segue e a data de início do seguimento.
-- Substitua 'Alice Silva' pelo nome do usuário desejado.
SELECT
    U.name AS user_name,
    P.name AS playlist_name,
    UHP.followed_date
FROM
    "User" AS U
JOIN
    User_Has_Playlist AS UHP ON U.id_user = UHP.id_user
JOIN
    Playlist AS P ON UHP.id_playlist = P.id_playlist
WHERE
    U.name = 'Alice Silva'; -- Exemplo: usuário 'Alice Silva'