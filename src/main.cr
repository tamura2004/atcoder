a = [7,5,3,1]
s = 0b1101

# ans = a.map_with_index do |v,i|
#   s.bit(i).odd? ? v : nil
# end.compact!

# ans = [] of Int32
# a.size.times do |i|
#   ans << a[i] if s.bit(i).odd?
# end


class Array(T)
  def select_with_index
    zip(0..).select{|v,i| yield i}.map(&.first)
  end
end

  ans = a.select_with_index{|i| s.bit(i).odd? }
  pp ans