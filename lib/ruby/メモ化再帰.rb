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
  
  # ---------------------------------------------------------
  class Problem
    MOD = 10007
    MAX = 10 ** 12
    attr_reader :a, :b, :c, :d, :memo, :cost
  
    def initialize(a, b, c, d)
      @a = a; @b = b; @c = c; @d = d
      @memo = { 0 => 0, 1 => @d }
      @cost = { 2 => @a, 3 => @b, 5 => @c}
    end
  
    def solve(n)
      return memo[n] if memo[n]
      mini = MAX
      candidates(n) do |to, cost|
        now = solve(to) + cost
        mini = now if now < mini
      end
      memo[n] = mini
    end
  
    def candidates(n)
      yield [0, d * n]
      [2, 3, 5].each do |i|
        j = cost[i]
        if i <= n
          yield [n / i, j + d * (n % i)]
        end
  
        if n % i != 0
          yield [(n + i - 1) / i, j + d * (i - n % i)]
        end
      end
    end
  end
  
  t = gets.to_i
  t.times do
    n, a, b, c, d = gets.split.map(&:to_i)
    pr = Problem.new(a, b, c, d)
    puts pr.solve(n)
  end
  
