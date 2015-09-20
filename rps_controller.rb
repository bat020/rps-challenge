require 'sinatra/base'
require_relative 'lib/rps_game'

class RockPaperScissors < Sinatra::Base

  get '/' do
    erb :index
  end

  post '/' do
    RpsGame.choose_player(params[:player])
    redirect '/play_rps'
  end

  get '/play_rps' do
    @player = RpsGame.setup[:player]
    @weapons = RpsGame.weapons
    erb :play_rps
  end

  post '/play_rps' do
    RpsGame.choose_player_weapon(params[:weapon])
    RpsGame.choose_computer_weapon
    RpsGame.play
    redirect '/results'
  end

  get '/results' do
    @player = RpsGame.setup[:player]
    @player_weapon = RpsGame.setup[:player_weapon]
    @computer_weapon = RpsGame.setup[:computer_weapon]
    @results = RpsGame.results
    erb :results
  end

  # start the server if ruby file executed directly
  run! if app_file == $PROGRAM_NAME

end
