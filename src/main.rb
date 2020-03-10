class PointChart
  attr_reader :chart
  def initialize(h,w)
    @h = h; @w = w; @n = h * w
    @chart = @h.times.map{ gets.split.map &:to_i }
  end
  def each
    @h.times{ |y| @w.times{ |x| yield y * 3 + x, @chart[y][x] }}
  end
  def total; @chart.flatten.inject(:+); end
end

B = PointChart.new(2,3)
C = PointChart.new(3,2)
TOTAL = B.total + C.total

# state := 長さ９の文字列で状態を持つ
# 1 := chokudai, 0 := naoko, ' ' := none

def score(state)
  ans = 0
  B.each{|i,c| ans += c if state[i] == state[i + 3]}
  C.each{|i,c| ans += c if state[i] == state[i + 1]}
  ans
end

MEMO = {}
def solve(state, turn)
  return MEMO[state] if MEMO[state]
  if turn == 9
    return MEMO[state] = score(state)
  end

  ans = []
  9.times do |i|
    next unless state[i] == " "
    next_state = state.dup
    next_state[i] = turn.even? ? "1" : "0"
    ans << solve(next_state, turn + 1)
  end
  MEMO[state] = turn.even? ? ans.max : ans.min
end

CHO = solve(" " * 9, 0)
NAO = TOTAL - CHO
puts CHO
puts NAO
