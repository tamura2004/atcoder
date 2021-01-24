n, m, k = gets.to_s.split.map { |v| v.to_i }
a = gets.to_s.split.map { |v| v.to_i }
ix = Array.new(n, false)
a.each do |i|
  ix[i] = true
end

# コーナーケース
cont = ix.map { |b| b ? "@" : "," }.join.split(/,+/).map(&:size).max
if k > 0 && m <= cont
  puts -1
  exit
end

m = m.to_f
dpa = Array.new(n + m, 0)
dpb = Array.new(n + m, 0)
csa = Array.new(n + m + 1, 0)
csb = Array.new(n + m + 1, 0)
(n - 1).downto(0) do |i|
  if ix[i]
    dpa[i] = 1
    dpb[i] = 0
  else
    dpa[i] = (csa[i + 1] - csa[i + m + 1]) / m
    dpb[i] = (csb[i + 1] - csb[i + m + 1]) / m + 1
  end
  csa[i] += csa[i + 1] + dpa[i]
  csb[i] += csb[i + 1] + dpb[i]
end
pp dpb[0] / (1 - dpa[0])
