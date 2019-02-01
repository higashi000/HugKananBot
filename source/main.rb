require 'twitter'

@client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['CONSUMER_KEY']
  config.consumer_secret     = ENV['CONSUMER_SECRET']
  config.access_token        = ENV['ACCESS_TOKEN']
  config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
end


$finalReplyID
$canFirst = true
def timeLine
  overlapReply = false
  kananSerif = ["ハグしよ！", "ダイブいい感じ！", "ご機嫌いかがかなん？", "8!", "訴えるよ", "何か心配事なら, 相談に乗るよ", "一緒に潜ってみる？", "ん？私ならここにいるよ", "あっはは。結構甘えん坊なんだね？　千歌に似てるかも♪", "焦らずいこう♪"]
  @client.home_timeline.each do |tweet|
    nowTime = Time.now

    if $finalReplyID == tweet.id then
      overlapReply = true
    end

    if tweet.text == "@Kanan136_bot ハグしよ！" && !overlapReply then
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
