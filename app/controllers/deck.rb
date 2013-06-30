get '/decks' do
  @decks = Deck.all
  @user = User.find(session["user"]) if session["user"]
  if @user
    erb :decks
  else
    redirect '/'
  end
end

