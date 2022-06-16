# さて何から考えよう
# y = 0b0101
# x = 0b0100
# これは成立する
# y = 0b1101
# x = 0b0100
# xのMSBより左が1のyについて、x^y > xだから、xのあまりになりえない
# xの2倍より小さくなくてはならない
# r = y - x
# 「あまり」が差になった
# y - x == y ^ x
# xがゼロなら常に成立
# 2 ** xのゼロの個数
# xが1なら、y＝＝１
#
# ただしy < rの制約を何とかする必要がある　=>　桁ＤＰ？

require "crystal/mod_int"

enum S
  Edge
  Free
end

l, r = gets.to_s.split.map(&.to_i64.to_s(2).chars.map(&.to_i))
pp dd(l)
pp dd(r)

def dd(a)
  n = a.size
  ndp = make_array(0.to_m, n + 1, 2)
  ndp[0][0] = 1.to_m

  vdp = make_array(0.to_m, n + 1, 2)
  vdp[0][0] = 1.to_m

  n.times do |i|
    S.each do |s|
      next if i.zero? && s.free?
      2.times do |d|
        next if s.edge? && a[i] < d
        ss = s.edge? && d == a[i] ? S::Edge : S::Free

        k = s.value
        kk = ss.value

        ndp[i + 1][kk] += ndp[i][k]
        if d.zero?
          vdp[i + 1][kk] += ndp[i][k] * 2
        else
          vdp[i + 1][kk] += vdp[i][k]
        end
      end
    end
  end

  vdp
end

# def zeros_under_msb(x)
#   Math.ilogb(x) + 1 - x.popcount
# end

# l, r = gets.to_s.split.map(&.to_i64)
# ans = (l..r).sum do |x|
#   2_i64 ** zeros_under_msb(x)
# end

# pp ans

# pp zeros_under_msb(10)
