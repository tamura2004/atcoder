require "crystal/modint9"

n, a1, a2, a3 = gets.to_s.split.map(&.to_i64)
dp = make_array(0.to_m, 65, a1, a2, a3)
dp[0][0][0][0] = 1.to_m

64.times do |i|
  a1.times do |j1|
    a2.times do |j2|
      a3.times do |j3|
        2.times do |k1|
          jj1 = j1
          if k1 == 1
            jj1 = (j1 + (1_i64 << i)) % a1
          end

          2.times do |k2|
            jj2 = j2
            if k2 == 1
              jj2 = (j2 + (1_i64 << i)) % a2
            end

            k3 = k1 ^ k2
            jj3 = j3
            if k3 == 1
              jj3 = (j3 + (1_i64 << i)) % a3
            end

            dp[i + 1][jj1][jj2][jj3] += dp[i][j1][j2][j3]
          end
        end
      end
    end
  end
end

pp dp
