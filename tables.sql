CREATE TABLE User (
    id_user INT PRIMARY KEY,
    img_user VARCHAR(255),
    name VARCHAR(100),
    password VARCHAR(100),
    gender VARCHAR(20),
    birth DATE,
    is_active BOOLEAN
);

CREATE TABLE Artist (
    id_artist INT PRIMARY KEY,
    id_user INT,
    pseudonym VARCHAR(100),
    is_active BOOLEAN,
    FOREIGN KEY (id_user) REFERENCES User(id_user)
);

CREATE TABLE Follows (
    follower_id_user INT,
    followed_id_user INT,
    start_date DATE,
    PRIMARY KEY (follower_id_user, followed_id_user),
    FOREIGN KEY (follower_id_user) REFERENCES User(id_user),
    FOREIGN KEY (followed_id_user) REFERENCES User(id_user)
);

CREATE TABLE Playlist (
    id_playlist INT PRIMARY KEY,
    name VARCHAR(100),
    creation_date DATE,
    total_tracks INT,
    duration_seconds INT,
    img VARCHAR(255),
    owner INT,
    FOREIGN KEY (owner) REFERENCES User(id_user)
);

CREATE TABLE User_Has_Playlist (
    id_user INT,
    id_playlist INT,
    PRIMARY KEY (id_user, id_playlist),
    FOREIGN KEY (id_user) REFERENCES User(id_user),
    FOREIGN KEY (id_playlist) REFERENCES Playlist(id_playlist)
);

CREATE TABLE Music (
    id_music INT PRIMARY KEY,
    name VARCHAR(100),
    img VARCHAR(255),
    release_date DATE,
    duration_seconds INT
);

-- 7. Album
CREATE TABLE Album (
    id_album INT PRIMARY KEY,
    title VARCHAR(100),
    release_date DATE,
    img VARCHAR(255),
    total_tracks INT,
    duration_seconds INT
);

CREATE TABLE Album_Has_Music (
    id_album INT,
    id_music INT,
    PRIMARY KEY (id_album, id_music),
    FOREIGN KEY (id_album) REFERENCES Album(id_album),
    FOREIGN KEY (id_music) REFERENCES Music(id_music)
);

CREATE TABLE Playlist_Has_Music (
    id_playlist INT,
    id_music INT,
    added_at TIMESTAMP,
    PRIMARY KEY (id_playlist, id_music),
    FOREIGN KEY (id_playlist) REFERENCES Playlist(id_playlist),
    FOREIGN KEY (id_music) REFERENCES Music(id_music)
);

CREATE TABLE Genre (
    name VARCHAR(100) PRIMARY KEY
);

CREATE TABLE Subgenre (
    name VARCHAR(100) PRIMARY KEY,
    parent_name_genre VARCHAR(100),
    FOREIGN KEY (parent_name_genre) REFERENCES Genre(name)
);

CREATE TABLE Music_Has_Genre (
    id_music INT,
    name VARCHAR(100),
    PRIMARY KEY (id_music, name),
    FOREIGN KEY (id_music) REFERENCES Music(id_music),
    FOREIGN KEY (name) REFERENCES Genre(name)
);

CREATE TABLE Artist_Owns_Music (
    id_artist INT,
    id_music INT,
    PRIMARY KEY (id_artist, id_music),
    FOREIGN KEY (id_artist) REFERENCES Artist(id_artist),
    FOREIGN KEY (id_music) REFERENCES Music(id_music)
);

INSERT INTO User (id_user, img_user, name, password, gender, birth, is_active) VALUES
(1, 'img1.jpg', 'Lucas', '1234', 'Male', '1995-05-01', TRUE),
(2, 'img2.jpg', 'Maria', 'abcd', 'Female', '1998-07-15', TRUE),
(3, 'img3.jpg', 'João', 'pass', 'Male', '2000-01-20', FALSE);

INSERT INTO Artist (id_artist, id_user, pseudonym, is_active) VALUES
(1, 1, 'DJ Luks', TRUE),
(2, 2, 'MariBeats', TRUE);

INSERT INTO Follows (follower_id_user, followed_id_user, start_date) VALUES
(1, 2, '2024-01-10'),
(2, 1, '2024-01-12'),
(3, 1, '2024-02-01');

INSERT INTO Playlist (id_playlist, name, creation_date, total_tracks, duration_seconds, img, owner) VALUES
(1, 'Top Hits', '2025-01-01', 2, 420, 'hits.jpg', 1),
(2, 'Relaxing Sounds', '2025-03-15', 1, 240, 'relax.jpg', 2);

INSERT INTO User_Has_Playlist (id_user, id_playlist) VALUES
(1, 1),
(2, 1),
(2, 2),
(3, 1);

INSERT INTO Music (id_music, name, img, release_date, duration_seconds) VALUES
(1, 'Sunrise', 'sunrise.jpg', '2024-12-01', 180),
(2, 'Dreamscape', 'dreamscape.jpg', '2024-11-15', 240),
(3, 'Night Ride', 'nightride.jpg', '2024-10-10', 200);

INSERT INTO Album (id_album, title, release_date, img, total_tracks, duration_seconds) VALUES
(1, 'Morning Vibes', '2024-12-05', 'morning.jpg', 2, 420),
(2, 'Chill Beats', '2024-11-20', 'chill.jpg', 1, 200);

INSERT INTO Album_Has_Music (id_album, id_music) VALUES
(1, 1),
(1, 2),
(2, 3);

INSERT INTO Playlist_Has_Music (id_playlist, id_music, added_at) VALUES
(1, 1, '2025-01-01 10:00:00'),
(1, 2, '2025-01-01 10:05:00'),
(2, 3, '2025-03-15 08:30:00');

INSERT INTO Genre (name) VALUES
('Electronic'),
('Lo-fi'),
('Pop');

INSERT INTO Subgenre (name, parent_name_genre) VALUES
('Synthwave', 'Electronic'),
('Chillhop', 'Lo-fi');

INSERT INTO Music_Has_Genre (id_music, name) VALUES
(1, 'Electronic'),
(2, 'Lo-fi'),
(3, 'Lo-fi'),
(3, 'Electronic');

INSERT INTO Artist_Owns_Music (id_artist, id_music) VALUES
(1, 1),
(1, 3),
(2, 2);

