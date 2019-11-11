require 'json'
require 'open-uri'

class GamesController < ApplicationController
  LETTERS = ""

  def new
    @alphabet = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
    @letters = @alphabet.shuffle[0..9]
  end

  def score
    @attempt = params[:longest_word]
    url = "https://wagon-dictionary.herokuapp.com/#{@attempt}"
    raw_data = open(url).read
    @new_data = JSON.parse(raw_data)
    @valid = @new_data["found"]
    @word_length = @new_data["length"]

    @new_letters = params[:letters].gsub(/\W/, "").split("")

    @overall = true
    @attempt.each_char do |character|
      if !@new_letters.include?(character)
        @overall = false
      end
    end
  end
end
