class Hand
  include Comparable(self)

  getter n : Tuple(Int32, Char)

  def initialize(s)
    @n = s.tally.map { |k, v| {-v, k} }.min
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
      Hand.new(fi + hi)
    end
  end
end

pp hands.zip(1..).min.last
