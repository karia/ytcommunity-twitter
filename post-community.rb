require 'twitter'

client = Twitter::REST::Client.new do |conf|
  conf.consumer_key = ENV['TWITTER_CONSUMER_KEY']
  conf.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
  conf.access_token = ENV['TWITTER_ACCESS_TOKEN']
  conf.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
end

list_file = "./list.txt"

#Node.jsからのファイルを読み込み
list_path = File.open(list_file).readlines

#URL組み立て
yturl = "[自動投稿発言です]ミコちゃんのYouTubeコミュニティが更新されました: " + "https://www.youtube.com" + list_path.first.slice(/'(.*)'/,1)

#Tweetする
client.update(yturl)
puts yturl

