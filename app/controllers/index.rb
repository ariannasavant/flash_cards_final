enable :sessions

get '/' do
	erb :index
end

post '/users' do
	@user = User.create(params[:user])
	session["user"] = @user.id
	redirect '/decks'
end

post '/sessions' do
	@user = User.authenticate(params[:user])
	if @user
		session["user"] = @user.id
		redirect '/decks'
	else
		password = nil
		erb :index
	end
end

get '/logout' do
	session.clear
	redirect '/'
end

get '/users/:id' do
	@user = User.find(params[:id])
	@latest_stats = { 	current_score: current_average(@user), 
											average_score: all_averages(@user), 
											deck: Deck.find(@user.rounds.last.deck_id).name
									}
	erb :user
end
