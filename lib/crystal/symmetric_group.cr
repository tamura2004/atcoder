# 対称群
struct SymmetricGroup
  getter a : Array(Int32)
  getter n : Int32
  delegate "[]", "to_s", to: a

  def initialize(@a)
    @n = a.size
  end

  # 置換の合成
  def *(b : self)
    ans = Array.new(n, -1)
    n.times do |i|
      ans[i] = a[b[i]]
    end
    S.new ans
  end

  # 逆元
  def - : self
    ans = Array.new(n, -1)
    n.times do |i|
      ans[a[i]] = i
    end
    S.new ans
  end

  #
end

alias S = SymmetricGroup