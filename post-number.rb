require 'twitter'
require 'yt'

# API Keyを取得
client = Twitter::REST::Client.new do |conf|
  conf.consumer_key = ENV['TWITTER_CONSUMER_KEY']
  conf.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
  conf.access_token = ENV['TWITTER_ACCESS_TOKEN']
  conf.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
end

Yt.configuration.api_key = ENV['YOUTUBE_API_KEY']

# configを取得
channel_id = ARGV[0]

# 登録者数取得
channel = Yt::Channel.new(id: channel_id)
num_after = channel.subscriber_count

# 数値がおかしいときは終了
if num_after == 0
  puts "ERRRO: 登録者数がゼロになっています。ツイートせず終了します。"
  exit 1
end

# 前回との差分を取得
list_file = "/var/tmp/number_" + channel_id + ".txt"
num_before = num_after

File.open(list_file, "r") do |f| 
  num_before = f.read.to_i
end

num_diff = num_after - num_before

# 文言組み立て
channel_name = channel.title
item = "YouTubeチャンネル " + channel_name + " の登録者数: " + num_after.to_s + " (" + Time.now.strftime("%m/%d %H:%M").to_s + "現在、前回チェック時との差分" + num_diff.to_s + ")"

#Tweetする
if num_diff == 0
  puts item
else
  client.update(item)
  puts "[ツイートしました]" + item
end

# 数字を保存
File.open(list_file, "w") do |f| 
  f.puts(num_after)
end

