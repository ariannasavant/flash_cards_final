helpers do 
  def current_average(user)
    all_guess_count = user.rounds.last.guesses.length.to_f
    correct_guess_count = user.rounds.last.guesses.select { |guess| guess[:is_correct] }.length.to_f
    (correct_guess_count / all_guess_count * 100).round(2)
  end

  def all_averages(user)
    scores = []
    current_deck_id = user.rounds.last.deck_id
    user.rounds.each do |round|
      if round.deck_id == current_deck_id
        all_guess_count = round.guesses.length.to_f
        correct_count = round.guesses.select { |guess| guess[:is_correct] }.length.to_f
        scores << (correct_count / all_guess_count * 100)
      end
    end
    (scores.inject(:+).to_f / scores.length.to_f).round(2)
  end
end
