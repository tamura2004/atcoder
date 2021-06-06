class Player
  attr_accessor :name
  attr_accessor :race
  attr_accessor :klass
  attr_accessor :lv
  attr_accessor :rpw
  attr_accessor :pw
  attr_accessor :rhp
  attr_accessor :hp
  attr_accessor :sp
  attr_accessor :place
  attr_accessor :gp
  attr_accessor :exp

  def initialize(id)
    @id = id
    @lv = 1
    @gp = 10
    @exp = 0
  end

  def set_race(data)
    _, name, @rpw, @rhp = data
    @race = name
    @pw = lv + rpw
    @hp = lv + rhp
  end

  def set_klass(data)
    _, name, sp = data
    @klass = name
    @sp = sp
  end

  def levelup(e)
    @exp += e
    if @lv * 10 <= @exp
      @lv += 1
      @pw = lv + rpw
      @hp = lv + rhp
      "#{name}はレベルアップ！#{klass} #{to_s}"
    else
      "#{name}は#{e}経験値を得た。"
    end
  end

  def raisefromdead
    @pw = lv + rpw
    @hp = lv + rhp
    @gp -= lv
    gp >= 0
  end

  def to_s
    "#{race}の#{klass}#{lv}lv #{pw}/#{hp} #{gp}gp #{exp}xp"
  end
end

def d3
  rand(5) - 2
end

class Monster
  attr_accessor :name, :lv, :pw, :hp, :cdm
  RANK= ["", "チーフ", "リーダー", "キング", "エンペラー", "ゴッド"]
  NAME = %w(ゴブリン オーク バグベア スケルトン ミノタウルス ゴーレム ドラゴン)

  def initialize(base_lv)
    @lv = base_lv + rand(3)
    @name = NAME[lv % 7] + RANK[lv / 7]
    @pw = lv + d3
    @hp = lv + d3
    @cdm = Hash.new(0)
  end

  def get_damage(dm, pc)
    cdm[pc] = dm if cdm[pc] < dm
  end

  def damage
    cdm.values.sum
  end

  def dead?
    hp <= damage
  end

  def to_s
    "#{name} 攻#{pw}/防#{hp - damage}"
  end
end

players = {}
monsters = []
races = [
  [/エルフ|える/, "エルフ", 2, 0],
  [/ドワーフ|どわ/, "ドワーフ", 0, 2],
  [/人間/, "人間", 1, 1],
]
klasses = [
  [/そう|僧侶/, "僧侶", "治癒"],
  [/まほ|魔法/, "魔法使い", "火球"],
  [/とう|盗賊/, "盗賊", "毒罠"],
  [/せん|戦士/, "戦士", "剣盾"],
]

def select_command(rs, a)
  rs.index{|r| r =~ a} || rand(rs.size)
end

class Author
  attr_accessor :display_name, :id
  def initialize
    @id = 1
    @display_name = "ななしさん"
  end
end

class Channel
  attr_accessor :name
  def initialize
    @name = "狂王の祭祀場"
  end
end

class Event
  attr_accessor :author, :content, :msgs, :channel
  def initialize
    @author = Author.new
    @msgs = []
    @channel = Channel.new
  end

  def <<(msg)
    msgs << msg
  end
end

class Bot
  attr_accessor :event

  def initialize
    @event = Event.new
  end

  def message
    loop do
      event.content = gets.chomp
      event.msgs = []
      yield event
      event.msgs.each do |msg|
        puts msg
      end
    end
  end
end

class Menu
  attr_accessor :yomi, :label

  def initialize(yomi, label)
    @yomi = yomi
    @label = label
  end
end

class Menues
  attr_accessor :menues

  def initialize(items)
    @menues = items.map do |item|
      Menu.new(*item)
    end
  end

  def <<(menu)
    menues << menu
  end

  def message
    msg = []
    menues.each_with_index do |menu, i|
      msg << "#{i+1}.[#{menu.yomi}]#{menu.label}"
    end
    msg.join(",")
  end

  def select(s)
    case s
    when /[1-9１-９]/
      i = s.to_i - 1
      (menues[i] || menues.sample).label
    else
      m = menues.find{|m| s =~ /#{m.yomi}/ || s =~ /#{m.label}/}
      m ||= menues.sample
      m.label
    end
  end
end


town_menues = Menues.new(
  [
    ["お", "王城"],
    ["ぶ", "武器屋"],
    ["ぼ", "防具屋"],
    ["だ", "ダンジョン"],
  ]
)

dungeon_menues = Menues.new(
  [
    ["た", "戦う"],
    ["さ", "探す"],
    ["す", "進む"],
    ["に", "逃げる"],
  ]
)

bot = Bot.new
bot.message do |event|
  next if event.channel.name != "狂王の祭祀場" && event.channel.name != "ボットデバッグ用"

  id = event.author.id
  auther = event.author.display_name
  pc = players[id]
  text = event.content

  case
  when pc.nil? || text =~ /りせっと/
    players[id] = Player.new(id)
    event << "#{auther}さんのキャラクターネームは？"
  when pc.name.nil?
    name = event.content
    pc.name = name
    event << "#{auther}さんのキャラクターは、#{name}さんです。種族は？"
  when pc.race.nil?
    race = races.find do |r|
      event.content =~ r[0]
    end || races[-1]
    pc.set_race(race)
    event << "#{pc.name}さんは#{pc.race}。クラスは？"
  when pc.klass.nil?
    klass = klasses.find do |c|
      event.content =~ c[0]
    end || klasses[-1]
    pc.set_klass(klass)
    event << pc.to_s
    pc.place = "リルガミン"
  when pc.place == "リルガミン"
    case town_menues.select(event.content)
    when /王城/
      event << "#{pc.name}は王城に行った。王様「支度金である」"
      pc.gp += pc.lv
      pc.exp -= pc.lv
    when /武器/
      if pc.gp >= pc.lv
        event << "#{pc.name}は武器屋に行った。折れた直剣を#{pc.lv}gpで買った。"
        pc.gp -= pc.lv
        pc.pw += pc.lv
      else
        event << "#{pc.name}は武器屋に行ったが所持金が足りない。"
      end
    when /防具/
      if pc.gp >= pc.lv
        event << "#{pc.name}は防具屋に行った。汚れた鎧を#{pc.lv}gpで買った。"
        pc.gp -= pc.lv
        pc.hp += pc.lv
      else
        event << "#{pc.name}は防具屋に行ったが所持金が足りない。"
      end
    when /ダンジョン/
      event << "#{pc.name}はダンジョンに入った"
      pc.place = "ダンジョン"
    end
  when pc.place == "ダンジョン"
    case dungeon_menues.select(event.content)
    when /戦う/
      m = monsters[0]
      dm = pc.pw + d3
      event << "#{pc.name}は#{m.to_s}に攻撃。#{dm}ダメージ。"
      m.get_damage(dm, id)
      if m.dead?
        event << "#{m.to_s}は死んだ。"
        monsters.shift
        event << pc.levelup(m.lv)
      else
        dm = m.pw + d3
        event << "#{m.to_s}の反撃。#{dm}ダメージ。"
        pc.hp -= dm
        if pc.hp <= 0
          pc.place = "カント寺院"
        else
        end
      end
    when /探す/
      if rand(6) < 3
        g = rand(1..10) * pc.lv
        pc.gp += g
        event << "#{g}gp見つけた。"
      else
        event << "なにも見つからなかった。"
      end
    when /進む/
      event << "#{pc.name}は奥に進む。"
    when /逃げる/
      event << "#{pc.name}は逃げ出した。"
      pc.place = "リルガミン"
    end
  end

  next if pc.nil?

  case pc.place
  when "ダンジョン"
    event << "#{pc.name}はダンジョンにいる。#{pc.to_s}"
    monsters << Monster.new(pc.lv) if monsters.empty?
    event << monsters.first.to_s
    event << "#{pc.name}はどうする？#{dungeon_menues.message}"
  when "カント寺院"
    if pc.raisefromdead
      event << "#{pc.name}は死んだ。カント寺院で蘇生。#{pc.lv}gp寄付した。"
      event << pc.to_s
      pc.place = "リルガミン"
    else
      event << "#{pc.name}は死んだ。蘇生費用が無い。ロストしました。"
      players.delete(id)
    end
  end

  if pc.place == "リルガミン"
    event << "#{pc.name}はどうする？#{town_menues.message}"
    event << pc.to_s
  end
end

bot.run
