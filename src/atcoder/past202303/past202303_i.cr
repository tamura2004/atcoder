

class Hand
  getter n : Tuple(Int32,Char)
  include Comparable(self)

  def initialize(s)
    c, i = s.tally.to_a.sort_by{|t|{t[0],-t[1]}}.first
    @n = {-i, c}
  end

  def <=>(b : self)
    n <=> b.n
  end
end

n = gets.to_s.to_i64
field = gets.to_s.chars

hands = (0...n).map do
  hand = gets.to_s.chars
  field.each_combination(3).min_of do |fi|
    hand.each_combination(2).min_of do |hi|
      Hand.new(fi+hi)
    end
  end
end

pp! hands

pp hands.zip(1..).sort.first.last