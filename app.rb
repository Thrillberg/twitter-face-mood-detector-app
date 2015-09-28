require 'sinatra'
require 'haml'

get '/' do
  @twitter_feeds = ["Breitbart News", "CBS Politics", "CNN Politics", "Huffington Post Politics", "Politico"]
  haml :index
end

post '/' do
  @twitter_feed = params[:twitter_feed]
  haml :results
end
