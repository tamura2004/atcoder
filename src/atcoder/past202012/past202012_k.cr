s = Array.new(4) { gets.to_s }.join.tr(".#", "01").to_i(2)
memo = Hash(Int32, Float64).new
memo[0] = 0.0_f64

solve = uninitialized (Int32) -> Float64
solve = ->(v : Int32) do
  if memo.has_key?(v)
    return memo[v]
  end

  ans = 1e9
  16.times do |i|
    y, x = i.divmod(4)
    cnt = 0
    tot = 1.0_f64

    [{-1, 0}, {1, 0}, {0, 0}, {0, 1}, {0, -1}].each do |dy, dx|
      ny = y + dy
      nx = x + dx
      j = ny * 4 + nx

      if nx < 0 || 4 <= nx || ny < 0 || 4 <= ny
        cnt += 1
      elsif v.bit(j) == 0
        cnt += 1
      else
        tot += solve.call(v ^ (1 << j)) / 5.0_f64
      end
    end

    if cnt < 5
      chmin ans, tot * 5 / (5 - cnt)
    end
  end
  memo[v] = ans
end
ans = solve.call(s)
pp ans
