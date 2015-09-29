require 'sinatra'
require 'haml'
require 'sinatra/activerecord'
require 'gruff'

set :database, {adapter: "sqlite3", database: "collection.sqlite3"}

class Collection < ActiveRecord::Base
  validates_presence_of :twitter_account, :img_url, :politcian, :text, :date, :mood, :sentiment
end

TWITTER_FEEDS = {"breitbart" => "Breitbart News", "cbs" => "CBS Politics", "cnn" => "CNN Politics", "huffpo" => "Huffington Post Politics", "politico" => "Politico"}
POLITICIANS = {"clinton" => ["Hillary Clinton", "Clinton", "Hillary", "@HillaryClinton"], "trump" => ["Donald Trump", "Trump", "@realDonaldTrump"]}


def analyze_moods(politician, twitter_feed)
  politician_names = []
  POLITICIANS.each do |pol|
    if politician == pol[1][0]
      politician_names = pol[1]
    end
  end

  moods = @collections.select { |entry| entry.twitter_account == twitter_feed && politician_names.include?(entry.politician) }
  freq = moods.inject(Hash.new(0)) { |h, v| h[v.mood] += 1;h }
end

def analyze_sentiments(politician, twitter_feed)
  politician_names = []
  POLITICIANS.each do |pol|
    if politician == pol[1][0]
      politician_names = pol[1]
    end
  end

  sentiments = @collections.select { |entry| entry.twitter_account == twitter_feed && politician_names.include?(entry.politician) }
  freq = sentiments.inject(Hash.new(0)) { |h, v| h[v.sentiment] += 1;h }
end


get '/' do
  @politicians = POLITICIANS
  @twitter_feeds = TWITTER_FEEDS
  haml :index
end

post '/' do
  @collections = Collection.all.where("mood = ? OR mood = ? OR mood = ? OR mood = ? OR mood = ? OR mood = ? OR mood = ?", 'scared', 'happy', 'sad', 'angry', 'disgusted', 'surprised', 'neutral')
  @twitter_feed = params[:twitter_feed]
  @politician = params[:politician]

  moods = analyze_moods(@politician, @twitter_feed)
  g = Gruff::Pie.new
  g.title_font_size = 25
  g.font = "/Library/Fonts/Arial.ttf"
  g.title = "#{@twitter_feed}'s representation of #{@politician}'s mood"
  g.data 'Scared', moods['scared']
  g.data 'Happy', moods['happy']
  g.data 'Angry', moods['angry']
  g.data 'Sad', moods['sad']
  g.data 'Surprised', moods['surprised']
  g.data 'Neutral', moods['neutral']
  g.data 'Disgusted', moods['disgusted']
  g.write("public/img/#{@politician}_#{@twitter_feed}_moods.png")
  
  sentiments = analyze_sentiments(@politician, @twitter_feed)
  g = Gruff::Pie.new
  g.font = "/Library/Fonts/Arial.ttf"
  g.title_font_size = 25
  g.title = "#{@twitter_feed}'s sentiment associated with #{@politician}"
  g.data 'Neutral', sentiments['neutral']
  g.data 'Positive', sentiments['positive']
  g.data 'Negative', sentiments['negative']
  g.write("public/img/#{@politician}_#{@twitter_feed}_sentiments.png")
  haml :results
end
