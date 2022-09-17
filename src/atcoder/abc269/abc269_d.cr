require "crystal/union_find"
require "crystal/complex"

n = gets.to_s.to_i
uf = n.to_uf

xy = Array.new(n) do
  C.read
end

(0...n - 1).each do |i|
  (i + 1...n).each do |j|
    case xy[i] - xy[j]
    when 1 + 0.i
      uf.unite i, j
    when -1 + 0.i
      uf.unite i, j
    when 1.i
      uf.unite i, j
    when -1.i
      uf.unite i, j
    when 1.i + 1
      uf.unite i, j
    when -1.i - 1
      uf.unite i, j
    end
  end
end

pp uf.size
