w, h, n = gets.split.map(&:to_i)

left = 0
right = w
top = h
bottom = 0

n.times do
  x, y, a = gets.split.map(&:to_i)
  case a
  when 1
    left = x if left < x
  when 2
    right = x if right > x
  when 3
    bottom = y if bottom < y
  when 4
    top = y if top > y
  end
end

ans = (left...right).size * (bottom...top).size
pp ans
