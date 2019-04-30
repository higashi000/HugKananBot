require 'twitter'

@client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['CONSUMER_KEY']
  config.consumer_secret     = ENV['CONSUMER_SECRET']
  config.access_token        = ENV['ACCESS_TOKEN']
  config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
end

def searchReply
  kananSerif = ["ハグしよ！", "ダイブいい感じ！", "ご機嫌いかがかなん？", "8!", "訴えるよ",
                "何か心配事なら, 相談に乗るよ", "一緒に潜ってみる？", "ん？私ならここにいるよ",
                "あっはは。結構甘えん坊なんだね？　千歌に似てるかも♪", "焦らずいこう♪"]

  searchString = "to:KananHug_bot"

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

    if getHug((tweet.text).to_s) && tweetTime > (nowTime - 2) then
      @client.update("@#{tweet.user.screen_name} #{kananSerif[rand(0 .. 9)]}", options = {:in_reply_to_status_id => tweet.id})
    end

    if getSlot((tweet.text).to_s) && tweetTime > (nowTime - 2) then

      cntDuplicate = 0

      getMusic = []

      getMusic[0] = musicSlot
      getMusic[1] = musicSlot
      getMusic[2] = musicSlot

      for i in getMusic do
        cnt = 0
        for j in getMusic do
          if i == j then
            cnt += 1
          end
        end
        if cnt > cntDuplicate then
          cntDuplicate = cnt
        end
      end


      if cntDuplicate == 3 then
        @client.update("@#{tweet.user.screen_name} ｼｭｨｨｨｨｨﾝ Music Slot!!\n「#{getMusic[0]}」\n「#{getMusic[1]}」\n「#{getMusic[2]}」\nやったねFULLCOMBO!!",
                       options = {:in_reply_to_status_id => tweet.id})
      elsif cntDuplicate == 2 then
        @client.update("@#{tweet.user.screen_name} ｼｭｨｨｨｨｨﾝ Music Slot!!\n「#{getMusic[0]}」\n「#{getMusic[1]}」\n「#{getMusic[2]}」\nもぉ〜！あとちょっとだったのに！！",
                       options = {:in_reply_to_status_id => tweet.id})
      elsif cntDuplicate == 1 then
        @client.update("@#{tweet.user.screen_name} ｼｭｨｨｨｨｨﾝ Music Slot!!\n「#{getMusic[0]}」\n「#{getMusic[1]}」\n「#{getMusic[2]}」\n成功とは...言い難いね...",
                       options = {:in_reply_to_status_id => tweet.id})
      end
    end
  end
end

def getHug(tweetText)
  if (tweetText["ハグ"])
    return true
  end

  return false
end

def getSlot(tweetText)
  if (tweetText["スロット"])
    return true
  end

  return false
end

def musicSlot
  music = ["君の心は輝いてるかい？", "Step! ZERO to ONE", "Aqours☆HEROES",
           "恋になりたいAQOUARIUM", "待ってて愛の歌", "届かない星だとしても",
           "青空Jumping Heart", "ハミングフレンド",
           "ユメ語るよりユメ歌おう", "サンシャインぴっかぴか温度",
           "夢で夜空を照らしたい", "未熟DREAMER",
           "Pops heartで踊るんだもん！",
           "想いよひとつになれ", "MIRAI TICKET",
           "ジングルベルがとまらない", "聖なる日の祈り",
           "Daydream warrior",
           "スリリング・ワンウェイ",
           "太陽を追いかけろ!",
           "HAPPY PARTY TRAIN", "SKY JOURNEY", "少女以上の恋がしたい",
           "Landing action Yeah!!",
           "未来の僕らは知ってるよ", "君の瞳をめぐる冒険",
           "勇気はどこに？君の胸に！", "\"MY LIST\" to you",
           "MY舞☆TONIGHT", "MIRACLE WAVE",
           "WATER BLUE NEW WORLD", "WONDERFUL STORIES",
           "キセキヒカル",
           "ホップ・ステップ・ワーイ！",
           "Thank you, FRIENDS!!", "No,10",
           "僕らの走ってきた道は・・・", "Next SPARKLING!!",
           "Hop?Stop?Nonstop!",
           "Brightest Melody",
           "Awaken the power", "Over The Next Rainbow",
           "元気全開DAY!DAY!DAY!", "夜空はなんでも知ってるの？",
           "P.S.の向こう側",
           "近未来ハッピーエンド", "海岸通りで待ってるよ",
           "サクラバイバイ",
           "トリコリコPLEASE!!", "ときめき分類学",
           "LONELY TUNING",
           "GALAXY HidE and SeeK", "INNOCENT BIRD",
           "卒業ですね",
           "Strawberry Trapper", "Guilty Night, Guilty Kiss!",
           "Guilty Eyes Fever",
           "コワレヤスキ", "Shadow gate to love",
           "Guilty!? Farewell Party",
           "SELF CONTROL!!", "CLASH MIND", "DROPOUT!?", "Believe again",
           "Waku-Waku-Week!", "ハジマリロード",
           "決めたよHand in Hand", "大好きだったらダイジョブ",
           "空も心も晴れるから", "Marine Border Parasol",
           "G線上のシンデレラ", "予測不可能Driving!", "逃走迷走メビウスループ",
           "夏への扉 Never end ver.", "真夏は誰のモノ？",
           "地元愛♡満タン☆サマーライフ", "夏の終わりの雨音が",
           "One More Sunshine Story", "おやすみなさん！", "in this unstable world",
           "Pianoforte Monologue", "Beginner's Sailing", "RED GEM WINK",
           "WHITE FIRST LOVE", "さかなかなんだか", "New winding road"
  ]


  return music[rand(0 .. (music.length - 1))]
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
    searchReply

    tweetFlg = false
  end
  if time.sec != 0 then
    tweetFlg = true
  end
end
