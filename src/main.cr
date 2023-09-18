class Want
  getter n : Int64
  getter slots : Array(Array(Int32))

  def initialize(@n, @slots)
    slots.map!(&.* 3)
  end

  def solve
    ans = [*0...3].each_permutation.min_of do |(i1, i2, i3)|
      10.times.min_of do |v|
        slots[i1].index(v).try do |j1|
          slots[i2].index(v, j1 + 1).try do |j2|
            slots[i3].index(v, j2 + 1).try do |j3|
              j3
            end
          end
        end || Int32::MAX
      end
    end

    ans == Int32::MAX ? -1 : ans
  end
end

class Got
  getter n : Int64
  getter slots : Array(Array(Int32))

  def initialize(@n, @slots)
  end

  def nex(a)
    a = a * 3
    n = a.size
    dp = make_array(nil.as(Int32?), n, 10)

    (0...n).reverse_each do |i|
      10.times do |j|
        if i < n - 1
          dp[i][j] = dp[i + 1][j]
        end

        if j == a[i]
          dp[i][j] = i
        end
      end
    end
    dp
  end

  def solve
    rees = slots.map { |r| nex r }

    ans = Int64::MAX
    10.times do |i|
      next if slots.any? { |r| !i.in?(r) }
      [*0...3].each_permutation do |(j, k, l)|
        pos = 0
        if pos2 = rees[j][pos][i]
          if pos3 = rees[k][pos2 + 1][i]
            if pos4 = rees[l][pos3 + 1][i]
              chmin ans, pos4
            end
          end
        end
      end
    end

    ans == Int64::MAX ? -1 : ans
  end
end

n = gets.to_s.to_i64
slots = Array.new(3) do
  gets.to_s.chars.map(&.to_i)
end

pp Got.new(n, slots).solve
