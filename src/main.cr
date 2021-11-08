require "crystal/modint9"

def pf(n, k, a, &block : Array(Int64) -> Nil)
  case
  when n == 0 then yield a
  when n == 1 then yield a
  when k == 1 then yield a
  else
    if k <= n
      a << k
      pf(n - k, k, a, &block)
      a.pop
    end

    pf(n, k - 1, a, &block)
  end
end

def calc(a, n, k, nf)
  return 1_i64 if a.empty?

  x1 = a.reduce { |s, t| s.lcm(t) }
  x2 = a.map(&.pred).product
  x3 = a.map(&.f).reduce { |s, t| s * t }
  x4 = (n - a.sum).f
  x1.to_m ** k * x2 * nf // x3 // x4
end

n, k = gets.to_s.split.map(&.to_i64)

ans = 0.to_m
nf = n.f

pf(n, n, [] of Int64) do |a|
  ans += calc(a, n, k, nf)
end

pp ans

# a <- pf
# (LCM ai) ** k * Π(ai - 1) n! // (Πai!)(n-Σai)!
