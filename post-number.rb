require 'twitter'
require 'yt'

client = Twitter::REST::Client.new do |conf|
  conf.consumer_key = ENV['TWITTER_CONSUMER_KEY']
  conf.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
  conf.access_token = ENV['TWITTER_ACCESS_TOKEN']
  conf.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
end

Yt.configuration.api_key = ENV['YOUTUBE_API_KEY']
channel_id = ARGV[0]

#登録者数取得
channel = Yt::Channel.new(id: channel_id)
number = channel.subscriber_count

#URL組み立て
item = "ミコちゃんのYouTubeチャンネル登録者数: " + number.to_s + " (" + Time.now.strftime("%m/%d %H:%M").to_s + "現在)"

#Tweetする
if number >= 50000
  client.update(item)
  puts "[ツイートしました]" + item
else
  puts item
end

list_file = "/var/tmp/number_" + channel_id + ".txt"
# 数字を保存
File.open(list_file, "w") do |f| 
  f.puts(number)
end

