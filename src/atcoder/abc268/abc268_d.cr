# 全探索
# 状態 => 文字列と探索の実装を分ける
# 状態は、undo可能であること、即ちスタック的な何か

record State, ord : Int32, pos : Int32, use : Int32, rest : Int32 do
  def nex(i, len, k)
    State.new(
      ord: i,
      pos: pos + len + 1 + k,
      use: use | (1 << i),
      rest: rest - k,
    )
  end
end

class Problem
  getter n : Int32
  getter m : Int32
  getter s : Array(String)
  getter t : Array(String)

  getter gap : Int32 # アンダーバー用に余分に使える個数
  getter dict : Set(String)
  getter state : Array(State)

  def self.read
    n, m = gets.to_s.split.map(&.to_i)
    s = Array.new(n) { gets.to_s }
    t = Array.new(m) { gets.to_s }
    new(n, m, s, t)
  end

  def initialize(@n, @m, @s, @t)
    @dict = t.to_set
    @state = [] of State
    @gap = 16 - (n - 1) - s.sum(&.size)
  end

  def solve
    n.times do |i|
      state << State.new(ord: i, pos: 0 , use: 1 << i, rest: gap)
      dfs
      state.pop
    end
    pp -1
  end

  def dfs
    if state.size == n
      finish?
    else
      n.times do |i|
        now = state[-1]
        next if now.use.bit(i) == 1
        (0..now.rest).each do |j|
          state << now.nex(i, s[now.ord].size, j)
          dfs
          state.pop
        end
      end
    end
  end

  def finish?
    str = to_s
    if !str.in?(dict) && 3 <= str.size <= 16
      puts str
      exit
    end
  end

  def to_s
    String.build do |io|
      n.times do |i|
        while io.bytesize < state[i].pos
          io << "_"
        end
        io << s[state[i].ord]
      end
    end
  end
end

Problem.read.solve
