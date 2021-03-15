# 集合のbit表現
record BitSet(N), v : Int64 do
  # 空集合
  def self.zero
    new(0)
  end

  def self.all
    new((1_i64 << N) - 1)
  end

  def inverse
    self ^ BitSet(N).all
  end

  {% for op in ["^","&","|"] %}
  def {{op}}(other : self)
    BitSet(N).new(v {{op}} other.v)
  end
  {% end %}

  # ブロックの評価値で初期化
  #
  # ```
  # BitSet(3).new(&.odd) # => 010
  # ```
  def initialize(&f : Int32 -> Bool)
    v = 0_i64
    N.times do |i|
      next unless f.call(i)
      v |= 1_i64 << i
    end
    initialize(v)
  end

  # 真偽値の配列で初期化
  #
  # ```
  # BitSet(3).new([true, false, false]) # => 001
  # ```
  def initialize(a : Array(Bool))
    initialize{|i|a[i]}
  end

  # 2進数形式の文字列で初期化
  def initialize(s : String)
    v = s.to_i64(2)
    initialize(v)
  end

  # デバッグ用
  #
  # ```
  # BitSet(3).new
  # ```
  def inspect : String
    sprintf("%0#{N}b", v)
  end
end