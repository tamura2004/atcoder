require "crystal/union_find"

n, q = gets.to_s.split.map(&.to_i)
tot = n
uf = (n + q + 1).to_uf

# 所属する箱番号、ボールから箱、なければ-1
box = Array.new(n+q+1, -1)
(1..n).each do |i|
  box[i] = i
end

# 箱に入っている代表番号（ufの親）なければ-1
#箱からボール
ball = Array.new(n+1, &.itself)

q.times do
  cmd, x, y = gets.to_s.split.map(&.to_i) + [0]

  case cmd
  when 1
    if ball[x] == -1
      if ball[y] == -1
      else
        box[uf.find(ball[y])] = x
        ball[x] = uf.find(ball[y])
        ball[y] = -1
      end
    else
      if ball[y] == -1
      else
        uf.unite ball[x], ball[y]
        box[uf.find(ball[x])] = x
        ball[x] = uf.find(ball[y])
        ball[y] = -1
        # pp! box[uf.find(6)]
      end
    end
  when 2
    tot += 1
    if ball[x] == -1
      ball[x] = tot
      box[tot] = x
    else
      uf.unite ball[x], tot
      box[uf.find(tot)] = x
    end
  when 3
    puts box[uf.find(x)]
  end
end


