require 'sinatra/base'
require 'time'
require 'date'

class Birthday < Sinatra::Base
  enable :sessions

  get '/' do
    erb(:welcome)
  end

  post '/birthday_screen' do
    session[:birthday] = params[:birthday]
    session[:name] = params[:name]
    redirect '/today'
  end

  get '/today' do
    @bday = session[:birthday]
    @name = session[:name]
    today = Date.today.strftime("%m-%d")
    bday = Date.parse(@bday).strftime("%m-%d")
    if bday == today
      erb(:bday)
    else
      redirect '/not_today'
    end
  end

  get '/not_today' do
    @bday = Date.parse(session[:birthday])
    @name = session[:name]
    bday = Date.new(Date.today.year, @bday.month, @bday.day)
    p bday
    if Date.today < bday
      @days_left = (Date.today - bday).to_i + 365
    else
      @days_left = (Date.today - bday).to_i
    end
    erb(:not_bday)
  end

  run! if app_file == $0
end
