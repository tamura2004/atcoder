require "crystal/indexable"

s = gets.to_s
x = gets.to_s.to_i64

puts Problem.new(s).solve(x)

class Problem
  getter s : String
  getter n : Int32
  getter len : Array(Int64)

  def initialize(@s)
    @n = s.size
    @len = [] of Int64
    n.times do |i|
      case s[i]
      when 'a'..'z'
        if len.empty?
          len << 1_i64
        else
          len << Math.min(len[-1] + 1, 1e16.to_i64)
        end
      when '0'..'9'
        if len.empty?
          len << 0_i64
        else
          d = s[i].to_i64
          len << Math.min(len[-1] * (d + 1), 1e16.to_i64)
        end
      end
    end
  end

  def solve(x)
    (0...n).reverse_each do |i|
      next if x <= len[i]

      if s[i + 1].in?('a'..'z')
        return s[i + 1]
      else
        x = (x - 1) % len[i] + 1
      end
    end
    return s[0]
  end
end
