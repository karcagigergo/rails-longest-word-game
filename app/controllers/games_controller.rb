require 'json'
require 'open-uri'

class GamesController < ApplicationController

    def home
    end

    def new
        @letters = ("A".."Z").to_a.sample(10)
    end
      
    def score
        @message = message
    end

    private

    def letter_included?(word, letters)
      word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
    end

    def english_word?(word)
        response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
        json = JSON.parse(response.read)
        return json['found']
    end

    def message
        letters = params[:letters].split
        word = params[:word].upcase
        letter_included = letter_included?(word, letters)
        if letter_included?(word, letters)
          if english_word?(word)
            "Congrats! #{word} is a valid English word!"
          else
            "Sorry but #{word} doesn't seem to be an english word.."
          end
        else
          "Sorry but #{word} can't be built out of #{letters.join(', ').upcase}"
        end
    end

end


