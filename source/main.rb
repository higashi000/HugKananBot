require 'twitter'
require './API'

@client = Twitter::REST::Client.new do |config|
  config.consumer_key        = CONSUMER_KEY
  config.consumer_secret     = CONSUMER_SECRET
  config.access_token        = ACCESS_TOKEN
  config.access_token_secret = ACCESS_TOKEN_SECRET
end


$finalReplyID
$canFirst = true
def timeLine
  kananSerif = ["ハグしよ！", "ダイブいい感じ！", "ご機嫌いかがかなん？", "8!", "訴えるよ", "何か心配事なら, 相談に乗るよ", "一緒に潜ってみる？", "ん？私ならここにいるよ", "あっはは。結構甘えん坊なんだね？　千歌に似てるかも♪", "焦らずいこう♪"]
  @client.home_timeline.each do |tweet|
    nowTime = Time.now

    if tweet.text == "@Kanan136_bot ハグしよ！" then
      if $finalReplyID == tweet.id then
        return
      end
      if $canFirst then
        $finalReplyID = tweet.id
        $canFirst = false
      end

      @client.update("@#{tweet.user.screen_name} #{kananSerif[rand(0 .. 9)]}", options = {:in_reply_to_status_id => tweet.id})
    end
  end
end

tweetFlg = true


loop do
  time = Time.new
  canTweet = time.sec

  if canTweet == 0 && tweetFlg then
    timeLine

    $canFirst = true
    tweetFlg = false
  end
  if canTweet != 0 then
    tweetFlg = true
  end
end

