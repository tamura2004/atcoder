# マージソートを書いてみよう
class Array(T)
  def merge(b : self)
    ([] of T).tap do |ans|
      while size > 0 || b.size > 0
        case
        when size.zero?
          ans << b.pop
        when b.size.zero?
          ans << pop
        else
          if last > b.last
            ans << pop
          else
            ans << b.pop
          end
        end
      end
    end.reverse
  end

  def merge_sort
    return self if size == 1
    left = self[...size//2].merge_sort
    right = self[size//2..].merge_sort
    left.merge(right)
  end
end

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
ans = a.merge_sort
puts ans.join(" ")
