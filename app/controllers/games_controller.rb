# require "json" => already required in rails
require "open-uri"

class GamesController < ApplicationController

  def new
    @random_letters = ('a'..'z').to_a.shuffle[0..9]
    return @random_letters
    #display random characters.times(10)
  end

  def valid?(word)
    @answer = params[:word]
    word_to_array = params[:word].split
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    dictionary = URI.open(url).read
    @words = JSON.parse(dictionary)

    if word_to_array.difference(@random_letters).any? == false
      if @words["found"] && @words["word"] == @answer
        @score =  "Congratulations! Your score is #{@words["length"]}!"
      elsif !words['found']
        @score = "#{@answer} is not an english word! Try again."
      end
    else
      @score = "the letters are not in the grid!"
    end
  end

  def answer
    @random_letters = params[:letters].split
    valid?(params[:word])
  end
end
