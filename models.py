from sqlalchemy import Column, Integer, String, Boolean, Date, DateTime, ForeignKey
from sqlalchemy.orm import declarative_base, relationship
from datetime import datetime

Base = declarative_base()

class User(Base):
    __tablename__ = 'User'
    id_user = Column(Integer, primary_key=True)
    img_user = Column(String(255))
    name = Column(String(100))
    password = Column(String(100))
    gender = Column(String(20))
    birth = Column(Date)
    is_active = Column(Boolean)

    playlists = relationship("Playlist", back_populates="owner_user")

class Artist(Base):
    __tablename__ = 'Artist'
    id_artist = Column(Integer, primary_key=True)
    id_user = Column(Integer, ForeignKey('User.id_user'))
    pseudonym = Column(String(100))
    is_active = Column(Boolean)

    user = relationship("User")

class Follows(Base):
    __tablename__ = 'Follows'
    follower_id_user = Column(Integer, ForeignKey('User.id_user'), primary_key=True)
    followed_id_user = Column(Integer, ForeignKey('User.id_user'), primary_key=True)
    start_date = Column(Date)

class Playlist(Base):
    __tablename__ = 'Playlist'
    id_playlist = Column(Integer, primary_key=True)
    name = Column(String(100))
    creation_date = Column(Date)
    total_tracks = Column(Integer)
    duration_seconds = Column(Integer)
    img = Column(String(255))
    owner = Column(Integer, ForeignKey('User.id_user'))

    owner_user = relationship("User", back_populates="playlists")

class UserHasPlaylist(Base):
    __tablename__ = 'User_Has_Playlist'
    id_user = Column(Integer, ForeignKey('User.id_user'), primary_key=True)
    id_playlist = Column(Integer, ForeignKey('Playlist.id_playlist'), primary_key=True)

class Music(Base):
    __tablename__ = 'Music'
    id_music = Column(Integer, primary_key=True)
    name = Column(String(100))
    img = Column(String(255))
    release_date = Column(Date)
    duration_seconds = Column(Integer)

class Album(Base):
    __tablename__ = 'Album'
    id_album = Column(Integer, primary_key=True)
    title = Column(String(100))
    release_date = Column(Date)
    img = Column(String(255))
    total_tracks = Column(Integer)
    duration_seconds = Column(Integer)

class AlbumHasMusic(Base):
    __tablename__ = 'Album_Has_Music'
    id_album = Column(Integer, ForeignKey('Album.id_album'), primary_key=True)
    id_music = Column(Integer, ForeignKey('Music.id_music'), primary_key=True)

class PlaylistHasMusic(Base):
    __tablename__ = 'Playlist_Has_Music'
    id_playlist = Column(Integer, ForeignKey('Playlist.id_playlist'), primary_key=True)
    id_music = Column(Integer, ForeignKey('Music.id_music'), primary_key=True)
    added_at = Column(DateTime, default=datetime.utcnow)

class Genre(Base):
    __tablename__ = 'Genre'
    name = Column(String(100), primary_key=True)

class Subgenre(Base):
    __tablename__ = 'Subgenre'
    name = Column(String(100), primary_key=True)
    parent_name_genre = Column(String(100), ForeignKey('Genre.name'))

class MusicHasGenre(Base):
    __tablename__ = 'Music_Has_Genre'
    id_music = Column(Integer, ForeignKey('Music.id_music'), primary_key=True)
    name = Column(String(100), ForeignKey('Genre.name'), primary_key=True)

class ArtistOwnsMusic(Base):
    __tablename__ = 'Artist_Owns_Music'
    id_artist = Column(Integer, ForeignKey('Artist.id_artist'), primary_key=True)
    id_music = Column(Integer, ForeignKey('Music.id_music'), primary_key=True)
