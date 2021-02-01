# 置換群
# ```
# a = [1,2,0,3]
# pg = PG.new(a)
# pg.inv # => [2,0,1,3]
# pg.fixed?(0) # => false
# pg.fixed?(3) # => true
# pg.swap(0,2)
# pg.a #=> [0,2,1,3]
# pg.inv #=> [0,2,1,3]
# ```
class PermutationGroup
  getter a : Array(Int32)
  getter inv : Array(Int32)

  def initialize(@a)
    n = a.size
    @inv = Array.new(n, -1)
    n.times do |i|
      inv[a[i]] = i
    end
  end

  def swap(i,j)
    inv.swap a[i],a[j]
    a.swap i,j
  end

  # 不動点
  def fixed?(i)
    a[i] == i
  end

  def value
    ({a,inv})
  end
end

alias PG = PermutationGroup