require 'pry'

class Jukebox
  attr_reader :songs, :commands

  def initialize(songs)
    @songs = songs
    @commands = %w( help list play exit )
  end

  def call
    input = sanitize(gets)

    case input

    when 'play'
      play

    when /play.+/
      play(input.gsub('play ', ''))

    else
      help
      list
    end
  end

  def help
    commands.each { |command| puts "--#{command}" }
  end

  def list
    @songs.each.with_index(1) { |song, i| puts "#{i}. #{song}" }
  end

  def play(song = nil)
    puts 'Which song would you like to play?' unless song

    song = song ? sanitize(song) : sanitize(gets)
    puts "Now Playing: #{users_choice(song)}"
  end

  private

  def sanitize(string)
    string.strip.downcase
  end

  def users_choice(input)
    is_a_digit = input.chars.all? { |c| c.ord.between?(48, 57) }
    is_a_digit ? find_by_index(input.to_i - 1) : find_by_name(input)
  end

  def find_by_index(index)
    songs[index]
  end

  def find_by_name(input)
    songs.find { |song| sanitize(song).include? input }
  end
end
