# dp
h, w = gets.to_s.split.map(&.to_i64)
r = gets.to_s.split.map(&.to_i64)
c = gets.to_s.split.map(&.to_i64)

a = Array.new(h) do
  gets.to_s.chars.map(&.to_i)
end

dp = make_array(1e15.to_i64, h, w, 2, 2)
dp[0][0][0][0] = 0_i64
dp[0][0][1][0] = c[0]
dp[0][0][0][1] = r[0]
dp[0][0][1][1] = c[0] + r[0]

h.times do |y|
  w.times do |x|
    2.times do |tate|
      2.times do |yoko|
        iro_mae = a[y][x] ^ tate ^ yoko

        # 右に移動、yokoは決まってる
        2.times do |move|
          # 0 tate
          # 1 yoko
          yy = y + (1 - move)
          xx = x + move
          next if h <= yy || w <= xx

          cost = {r[yy],c[xx]}[move]

          2.times do |flip|
            n_tate = {tate, flip}[move]
            n_yoko = {flip, yoko}[move]

            iro_ato = a[yy][xx] ^ n_tate ^ n_yoko
            next if iro_mae != iro_ato

            chmin dp[yy][xx][n_tate][n_yoko], dp[y][x][tate][yoko] + cost * flip
          end
        end
      end
    end
  end
end

pp dp[-1][-1].flatten.min
