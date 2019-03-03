require 'twitter'

@client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['CONSUMER_KEY']
  config.consumer_secret     = ENV['CONSUMER_SECRET']
  config.access_token        = ENV['ACCESS_TOKEN']
  config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
end

def timeLine
  kananSerif = ["ハグしよ！", "ダイブいい感じ！", "ご機嫌いかがかなん？", "8!", "訴えるよ",
                "何か心配事なら, 相談に乗るよ", "一緒に潜ってみる？", "ん？私ならここにいるよ",
                "あっはは。結構甘えん坊なんだね？　千歌に似てるかも♪", "焦らずいこう♪"]

  searchString = "to:Kanan136_bot"

  time = Time.new
  nowTime = time.year.to_s

  if countDigit(time.mon) == 1 then
    nowTime += "0" + time.mon.to_s
  else
    nowTime += time.mon.to_s
  end

  if countDigit(time.day) == 1 then
    nowTime += "0" + time.day.to_s
  else
    nowTime += time.day.to_s
  end

  if countDigit(time.hour) == 1 then
    nowTime += "0" + time.hour.to_s
  else
    nowTime += time.hour.to_s
  end

  if countDigit(time.min) == 1 then
    nowTime += "0" + time.min.to_s
  else
    nowTime += time.min.to_s
  end

  nowTime = nowTime.to_i

  @client.search(searchString, :count => 100).map do |tweet|

    tweetTime = getTweetTime(tweet.id).strftime("%Y%m%d%H%M").to_i

    if tweetTime <= (nowTime - 2) then
      break
    end

    if tweet.text == "@Kanan136_bot ハグしよ！" && tweetTime > (nowTime - 2) then
      @client.update("@#{tweet.user.screen_name} #{kananSerif[rand(0 .. 9)]}", options = {:in_reply_to_status_id => tweet.id})
    end
  end
end

def getTweetTime(id)
  return Time.at(((id.to_i >> 22) + 1288834974657) / 1000.0)
end

def countDigit(num)
  return num.to_s.length
end

tweetFlg = true

loop do
  time = Time.new

  if time.sec == 0 && tweetFlg then
    timeLine

    tweetFlg = false
  end
  if time.sec != 0 then
    tweetFlg = true
  end
end
