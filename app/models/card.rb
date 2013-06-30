class Card < ActiveRecord::Base
  belongs_to :deck
  has_many :guesses


  def correct?(guess)
    self.answer.downcase == guess.downcase
  end

end
