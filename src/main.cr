def pf(n, k, a, &block : Array(Int32) -> Nil)
  case
  when n == 0
    yield a
  when n == 1
    a << 1
    yield a
    a.pop
  when k == 1
    n.times { a << 1 }
    yield a
    a.pop(n)
  else
    if k <= n
      a << k
      pf(n - k, k, a, &block)
      a.pop
    end

    pf(n, k - 1, a, &block)
  end
end

ans = 0_i64
pf(10, 10, [] of Int32) do |a|
  pp a
end

pp ans

# a <- pf
# (LCM ai) ** k * Π(ai - 1) n! // (Πai!)(n-Σai)!
