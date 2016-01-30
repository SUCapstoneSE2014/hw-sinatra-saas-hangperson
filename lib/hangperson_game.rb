class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess(lettr)
    if lettr == '' || lettr == nil || !(lettr =~ /[[:alpha:]]/)
      raise ArgumentError
    end
    lettr.downcase!
    if @word.include? lettr
      if !guesses.include? lettr
        guesses << lettr
      else 
        return false
      end
    else
      if !wrong_guesses.include? lettr
        wrong_guesses << lettr
      else
        return false
      end
    end
  end
  
  def word_with_guesses
    result = ""
    @word.each_char do |lett|
      if @guesses.include? lett
        result << lett
      else
        result << '-'
      end
    end
    return result
  end
  
  def check_win_or_lose
    if !word_with_guesses.include? '-'
      return :win
    elsif wrong_guesses.size == 7
      return :lose
    else
      return :play
    end
  end
  
end
