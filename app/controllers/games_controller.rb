require "open-uri"

class GamesController < ApplicationController
  def new
    @grid = rand(5..10)
    @letters = ('A'..'Z').to_a
    @letters = @grid.times.map { @letters.sample }
  end

  def score
    @attempt = params[:word]
    @score = 0
    check_word = JSON.parse(URI.open("https://wagon-dictionary.herokuapp.com/#{@attempt}").read)
    # @response = 'Is not an English word' unless check_word['found']
    attempt_ar = @attempt.upcase.chars
    letters = params[:letters].split(' ')
    if !check_word['found']
      @response = 'Is not an English word'
    elsif attempt_ar.all? { |letter| attempt_ar.count(letter) <= letters.count(letter) }
      @response = 'well done'
      @score += (@attempt.size + 100)
    else
      @response = 'the given word is not in the grid'
    end
  end
end
