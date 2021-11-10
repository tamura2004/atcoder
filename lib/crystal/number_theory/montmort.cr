class Montmort
  getter n : Int32

  def initialize(@n)
  end

  def solve
    ans = n.f
    cnt = 2.upto(n).sum do |k|
      -1.to_m ** k // k.f
    end
    return ans * cnt
  end
end
