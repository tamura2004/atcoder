require "crystal/avl_tree"

n, k = gets.to_s.split.map(&.to_i)
k -= 1
x = gets.to_s.split.map(&.to_i).zip(1..)

tr = AVLTree(Tuple(Int32, Int32)).new
n.times do |i|
  tr << x[i]

  next if i < k
  tr[k].try do |i, j|
    pp j
  end
end
