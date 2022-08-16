N = 8
MAX = N * (N - 1) + 1

def is_magic_circle?(a)
  check = Array.new(MAX + 1) { false }
  csum = Array.new(N + 1) { 0 }

  a.each_with_index do |v, i|
    csum[i + 1] = csum[i] + v
  end

  return false if csum[N] != MAX

  for i in 0...N
    for j in (i + 1)...N
      s = csum[j] - csum[i]
      return false if check[s] || check[MAX - s]
      check[s] = true
      check[MAX - s] = true
    end
  end
  true
end

(1..(MAX - N)).to_a.permutation(N - 1) do |a|
  s = MAX - a.sum
  next if s < 1
  a.push(s)
  if is_magic_circle?(a)
    p a
    exit
  end
end
