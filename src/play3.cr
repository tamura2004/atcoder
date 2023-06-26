cnt = 0

->do
  10.times do |i|
    10.times do |j|
      cnt += j
      return if cnt > 100
    end
  end
end.call

def or(x, y)
  x | y
end

pp [1, 2, 3, 4].reduce(&->(x : Int32, y : Int32) { x | y })
pp [1, 2, 3, 4].reduce { |x, y| x | y }

pp cnt
