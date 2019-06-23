require 'pry'
class Song
  
  attr_accessor :name
  attr_reader :artist, :genre
  
  @@all =[]
  
  def initialize(name, artist = nil, genre = nil)
    @name=name
    self.artist=(artist) if artist
    self.genre=(genre) if genre
  end
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def save
    @@all << self
  end
  
  def self.create(song)
    s = Song.new(song)
    s.save
    s
  end
  
  def artist=(artist = nil)
    @artist = artist
    artist.add_song(self)
  end
  
  def genre=(genre = nil)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self) 
  end
  
  def new_wtih_atist(song, artist)
    self.create(song)
    song.artist = artist
  end
  
  def self.find_by_name(name)
    @@all.find {|song| song.name ==name}
  end
  
  def self.find_or_create_by_name(name)
    self.find_by_name(name)||self.create(name)
  end
  
  def self.new_from_filename(file_name)
   artist = file_name.split(" - ")[0]
   name = file_name.split(" - ")[1]
   genre = file_name.split(" - ")[2].gsub(".mp3",'')
   
   artist = Artist.find_or_create_by_name(artist)
   genre = Genre.find_or_create_by_name(genre)
   new(name,artist,genre)
   
  end
  
  def self.create_from_filename(file_name)
    new_from_filename(file_name).save
  end
end