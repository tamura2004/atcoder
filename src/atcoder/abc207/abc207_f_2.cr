require "crystal/graph"
require "crystal/mod_int"

n = gets.to_s.to_i
g = n.to_g
(n - 1).times do
  g.read
end

# dp[i警備された頂点の個数][j根を使用するかどうか][k警備されているか]

dfs = uninitialized (Int32, Int32) -> Array(Array(Array(ModInt)))
dfs = -> (v : Int32, pv : Int32) do
  dp = make_array(0.to_m, 2, 2, 2)
  dp[0][0][0] = 1.to_m
  dp[1][1][1] = 1.to_m

  g.each(v) do |nv|
    next if nv == pv
    ret = dfs.call(nv, v)
    ndp = make_array(0.to_m, dp.size + ret.size, 2, 2)
    dp.each_index do |i|
      ret.each_index do |j|
        2.times do |i_use|
          2.times do |i_cover|
            next if i_use == 1 && i_cover == 0
            2.times do |j_use|
              2.times do |j_cover|
                next if j_use == 1 && j_cover == 0
                ii = i + j
                ii += 1 if (j_cover == 0 && i_use == 1) ||(j_use == 1 && i_cover == 0)
                ii_cover = i_use | j_use | i_cover
                ndp[ii][i_use][ii_cover] += dp[i][i_use][i_cover] * ret[j][j_use][j_cover]
              end
            end
          end
        end
      end
    end
    dp = ndp    
  end
  dp
end
puts dfs.call(0, -1).map(&.flatten.sum).first(n+1).join("\n")