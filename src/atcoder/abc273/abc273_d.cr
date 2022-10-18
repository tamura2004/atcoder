require "crystal/balanced_tree/treap/ordered_set"

h, w, y, x = gets.to_s.split.map(&.to_i)
n = gets.to_s.to_i

tate = Hash(Int32, OrderedSet(Int32)).new { |h, k| h[k] = OrderedSet(Int32).new }
yoko = Hash(Int32, OrderedSet(Int32)).new { |h, k| h[k] = OrderedSet(Int32).new }

n.times do
  _y, _x = gets.to_s.split.map(&.to_i)

  yoko[_y] << _x
  tate[_x] << _y
end

q = gets.to_s.to_i
q.times do
  d, l = gets.to_s.split
  len = l.to_i
  case d
  when "L"
    lo = yoko.has_key?(y) ? (yoko[y].lower(x) || 0) : 0
    x = Math.max(lo + 1, x - len)
  when "R"
    hi = yoko.has_key?(y) ? (yoko[y].upper(x) || (w + 1)) : (w + 1)
    x = Math.min(hi - 1, x + len)
  when "U"
    lo = tate.has_key?(x) ? (tate[x].lower(y) || 0) : 0
    y = Math.max(lo + 1, y - len)
  when "D"
    hi = tate.has_key?(x) ? (tate[x].upper(y) || (h + 1)) : (h + 1)
    y = Math.min(hi - 1, y + len)
  end

  puts "#{y} #{x}"
end
