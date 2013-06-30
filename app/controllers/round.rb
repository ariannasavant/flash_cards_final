get '/rounds' do
  @user = User.find(session["user"]) if session["user"]
  deck_id = params[:deck_id]
  round = Round.create(user_id: session["user"], deck_id: deck_id)
  session[:deck_id] = deck_id
  session[:round_id] = round.id  
  erb :round
end

get '/rounds/card_order' do
  Deck.find(session[:deck_id]).cards.map { |card| card.id }.shuffle.to_json
end

get '/rounds/get_question' do
    @card = Card.find(params[:card_id])
    erb :_question, :layout => false
end

post '/rounds/submit_guess' do
  @card = Card.find(params[:card_id])
  guess = Guess.create(round_id: session[:round_id], is_correct: @card.correct?(params[:guess]), card_id: @card.id)
  @correct = guess.is_correct
  erb :_answer, :layout => false
end
