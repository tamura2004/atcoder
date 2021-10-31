class Kmp
  getter s : String
  getter n : Int32
  getter a : Array(Int32)

  def initialize(@s)
    @n = s.size
    @a = Array.new(n + 1, -1)
  end
  
  def solve
    j = -1
    n.times do |i|
      while j >= 0 && s[i] != s[j]
        j = a[j]
      end
      j += 1
      a[i + 1] = j
    end
    a
  end
end
