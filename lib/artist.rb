  require 'pry'

class Artist 
  extend Concerns::Findable
  
  attr_accessor :name, :songs
  
  @@all =[]
  
  def initialize(name, artist = nil)
    @name=name
    @songs=[]
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
  
  def add_song(song)
    song.artist = self unless song.artist==self
    songs << song unless songs.include?(song)
  end
  
  def self.create(artist)
    a = Artist.new(artist)
    a.save
    a
  end
  
  def genres
    songs.collect {|song| song.genre}.uniq
  end
  
end    