class Manacher
  getter s : String
  getter n : Int32

  def initialize(@s)
    @n = s.size
  end

  def solve
    ans = Array.new(n, 0)
    i = j = 0

    while i < n
      while i - j >= 0 && i + j < n && s[i-j] == s[i+j]
        j += 1
      end

      ans[i] = j
      k = 1

      while i - k >= 0 && i + k < n && k + ans[i-k] < j
        ans[i+k] = ans[i-k]
        k += 1
      end

      i += k
      j -= k
    end

    ans
  end
end

s = gets.to_s
s = "@" + s.chars.join("@") + "@"
cnt = Manacher.new(s).solve
cnt.shift
cnt.pop
ans = cnt.map(&.- 1)
puts ans.join(" ")