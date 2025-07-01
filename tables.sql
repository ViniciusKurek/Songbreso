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
