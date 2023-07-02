# ２数の組みはx-y平面上にプロットして考察する
# x < yの制約がある場合、無意識にyiが単調増加であると誤解してしまう自分の傾向を自覚
# クーポン　→ 商品の包含関係を見て誤解。クーポンの適用金額が大きい方が、商品の対象が少ない。＞商品の金額が小さい方から適用
# 商品→クーボンを考えれば誤解に気づけたはず

# 平面走査＞イベントソート
# 現在使用できる最大の値引き率のクーポンを使用（ToDo：マトロイドの言葉で貪欲の正当性を証明）

require "crystal/priority_queue"

enum Type
  Coupon
  Item
end

record Event, price : Int64, discount : Int64, type : Type do
  include Comparable(Event)
  def <=>(other : self)
    to_tuple <=> other.to_tuple
  end

  def to_tuple
    {price, type, discount}
  end
end

n, m = gets.to_s.split.map(&.to_i64)
item = gets.to_s.split.map(&.to_i64)
coupon = gets.to_s.split.map(&.to_i64).zip(gets.to_s.split.map(&.to_i64))

events = [] of Event
item.each do |price|
  events << Event.new price, 0_i64, Type::Item
end
coupon.each do |price, discount|
  events << Event.new price, discount, Type::Coupon
end
events.sort!

pq = PriorityQueue(Event).new do |x, y|
  x.discount < y.discount
end

ans = 0_i64
events.each do |event|
  case event.type
  when .item?
    if pq.empty?
      ans += event.price
    else
      cp = pq.pop
      ans += event.price - cp.discount
    end
  when .coupon?
    pq << event
  end
end

pp ans