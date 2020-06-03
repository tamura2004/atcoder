N = gets.not_nil!.to_i
Ps = gets.not_nil!.split
 
ds = (0 ... N*N).map{|i| [i%N, i//N, N - 1 - i%N, N - 1 - i//N].min}
es = Array(Bool).new(N*N, false)
ans = 0
Ps.map{|p| p.to_i - 1}.each do |i|
  ans += ds[i]
  es[i] = true
  s = [i]
  while !s.empty?
    j = s.pop
    d = es[j] ? ds[j] : ds[j] + 1
    if j - N >= 0 && ds[j - N] > d
      ds[j - N] = d
      s << j - N
    end
    if j + N < N*N && ds[j + N] > d
      ds[j + N] = d
      s << j + N
    end
    if j%N != 0 && ds[j - 1] > d
      ds[j - 1] = d
      s << j - 1
    end
    if j%N != N - 1 && ds[j + 1] > d
      ds[j + 1] = d
      s << j + 1
    end
  end
end
puts ans