enum Muki
  Tate
  Yoko

  def ~
    self.tate? ? Yoko : Tate
  end
end

class MukiArray(T)
  private getter a : Array(Array(T))

  def initialize(@a)
  end

  def [](d : Muki, i : Int32, j : Int32)
    case d
    in .tate? then a[i][j]
    in .yoko? then a[j][i]
    end
  end

  def []=(d : Muki, i : Int32, j : Int32, v : T)
    case d
    in .tate? then a[i][j] = v
    in .yoko? then a[j][i] = v
    end
  end
end

class HashCount(K)
  private getter h : StaticArray(Int64, 26)
  private getter sum : Int64

  def initialize
    @h = StaticArray(Int64, 26).new(0)
    @sum = 0_i64
  end

  def [](k : K)
    h[k.ord - 'a'.ord]
  end

  def []=(k : K, v : Int64)
    @sum += v - self[k]
    h[k.ord - 'a'.ord] = v
  end

  def delete(k : K)
    @sum -= self[k]
    self[k] = 0_i64
  end

  def valid? : K?
    h.index(&.!= 0).try do |i|
      h[i] == sum >= 2 ? ('a'.ord + i).chr : nil
    end
  end
end

h, w = gets.to_s.split.map(&.to_i)
len = {Muki::Tate => h, Muki::Yoko => w}
c = MukiArray(Char).new Array.new(h) { gets.to_s.chars }

cnt = Hash(Muki, Array(HashCount(Char))).new do |h, k|
  h[k] = Array.new(len[k]) { HashCount(Char).new }
end
seen = MukiArray(Bool).new Array.new(h) { Array.new(w, false) }
ans = h * w
q = Deque(Tuple(Muki, Int32, Char)).new
used = Set(Tuple(Muki, Int32)).new

h.times do |y|
  w.times do |x|
    chr = c[Muki::Tate, y, x]
    cnt[Muki::Tate][y][chr] += 1
    cnt[Muki::Yoko][x][chr] += 1
  end

  if key = cnt[Muki::Tate][y].valid?
    q << {Muki::Tate, y, key}
    used << {Muki::Tate, y}
  end
end
w.times do |x|
  if key = cnt[Muki::Yoko][x].valid?
    q << {Muki::Yoko, x, key}
    used << {Muki::Yoko, x}
  end
end

while q.size > 0
  d, i, key = q.shift
  cnt[d][i].delete(key)

  len[~d].times do |j|
    next if seen[d, i, j]
    next if c[d, i, j] != key
    seen[d, i, j] = true
    ans -= 1
    cnt[~d][j][key] -= 1

    if n_key = cnt[~d][j].valid?
      next if used.includes?({~d, j})
      used << {~d, j}
      q << {~d, j, n_key}
    end
  end
end

pp ans
