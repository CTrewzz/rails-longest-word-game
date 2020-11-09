require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @grid = params[:grid]
    @answer = params[:answer]
    grid_letters = @grid.each_char { |letter| print letter, '' }
    if !letter_in_grid
      @result = "Sorry, the #{@answer.upcase} can't be create from #{grid_letters}."
    elsif !english_word
      @result = "Sorry, but #{@answer.upcase} is not an English word."
    else letter_in_grid && english_word
      @result = "Congratulation! #{@answer.upcase} is a valid English word."
    end
  end

  def letter_in_grid
    @answer.chars.sort.all? { |letter| @grid.include?(letter) }
  end

  def english_word
    word_dictionary = open("https://wagon-dictionary.herokuapp.com/#{@answer}")
    word = JSON.parse(word_dictionary.read)
    p word
    return word['found']
  end
end
