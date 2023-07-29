# require "crystal/lazy_segment_tree"

# 区間加算、区間最大
# def self.range_add_range_max(n : I)
#   values = Array(X).new(n, X.zero)
#   range_add_range_max(values)
# end

class IMOS2D
  getter h : Int32
  getter w : Int32
  getter a : Array(Array(Int64))

  def initialize(@h, @w)
    @a = Array.new(h + 1) { Array.new(w + 1, 0_i64) }
  end

  def add(x1, y1, x2, y2)
    a[y1][x1] += 1
    a[y1][x2] -= 1
    a[y2][x1] -= 1
    a[y2][x2] += 1
  end

  def update!
    (0..h).each do |y|
      (1..w).each do |x|
        a[y][x] += a[y][x - 1]
      end
    end

    (0..w).each do |x|
      (1..h).each do |y|
        a[y][x] += a[y - 1][x]
      end
    end
  end

  def max(x1, y1, x2, y2)
    (x1..x2).max_of do |x|
      (y1..y2).max_of do |y|
        a[y][x]
      end
    end
  end
end

record Pr, i : Int32, x1 : Int64, y1 : Int64, z1 : Int64, x2 : Int64, y2 : Int64, z2 : Int64

n = gets.to_s.to_i
cho = Array.new(n) do |i|
  x1, y1, z1, x2, y2, z2 = gets.to_s.split.map(&.to_i64)
  Pr.new i, x1, y1, z1, x2, y2, z2
end

ans = Array.new(n, 0_i64)

gr = Array.new(101) { [] of Pr }
cho.each do |ch|
  gr[ch.x1] << ch
  gr[ch.x2] << ch
end

gr.each do |prs|
  prs.sort_by!(&.y1)

  imos = IMOS2D.new(101, 101)
  prs.each do |pr|
    imos.add(pr.y1, pr.z1, pr.y2, pr.z2)
  end
  imos.update!

  prs.each do |pr|
    ans[pr.i] += imos.max(pr.y1, pr.z1, pr.y2, pr.z2) - 1
  end
end

gr = Array.new(101) { [] of Pr }
cho.each do |ch|
  gr[ch.y1] << ch
  gr[ch.y2] << ch
end

gr.each do |prs|
  imos = IMOS2D.new(101, 101)
  prs.each do |pr|
    imos.add(pr.x1, pr.z1, pr.x2, pr.z2)
  end
  imos.update!

  prs.each do |pr|
    ans[pr.i] += imos.max(pr.x1, pr.z1, pr.x2, pr.z2) - 1
  end
end

gr = Array.new(101) { [] of Pr }
cho.each do |ch|
  gr[ch.z1] << ch
  gr[ch.z2] << ch
end

gr.each do |prs|
  imos = IMOS2D.new(101, 101)
  prs.each do |pr|
    imos.add(pr.x1, pr.y1, pr.x2, pr.y2)
  end
  imos.update!

  prs.each do |pr|
    ans[pr.i] += imos.max(pr.x1, pr.y1, pr.x2, pr.y2) - 1
  end
end

puts ans.join("\n")
