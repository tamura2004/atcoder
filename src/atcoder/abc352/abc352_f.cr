# bit全探索
# 重みつきufで連結成分毎にマスク化 { 0b1101, [2, 7, 6] }
# dfsで探索
# 候補を列挙、成功した候補の数を返す
# 候補の正解数が１なら、その候補で確定
# 複数あるなら未確定

require "crystal/union_find"

n, m = gets.to_s.split.map(&.to_i64)
uf = n.to_uf
m.times do
  a,b,c = gets.to_s.split.map(&.to_i64)
  a -= 1
  b -= 1
  uf.unite b, a, c
end

masks = uf.group_children.map do |arr|
  base = arr[0]
  arr.sort_by! do |v|
    uf.diff(base, v)
  end
  mask = 1
  arr.each do |v|
    mask |= (1 << (uf.diff(arr[0], v)))
  end
  { mask, arr }
end

nn = masks.size

TBD = -1
IMP = -2
ans = Array.new(nn, TBD)

dfs = uninitialized Proc(Int32, Int32, Bool)
dfs = -> (seen : Int32, i : Int32) do
  if i == nn
    true
  else
    mask, arr = masks[i]
    lo = 0
    hi = n - mask.bit_length
    flag = false
    (lo..hi).each do |j|
      nmask = mask << j
      next if seen & nmask != 0
      if result = dfs.call(seen | nmask, i + 1)
        case ans[i]
        when TBD
          ans[i] = j
        when IMP
        else
          if ans[i] != j
            ans[i] = IMP
            return true
          end
        end
        flag = true
      end
    end
    flag
  end
end

dfs.call(0, 0)

a = Array.new(n, -1_i64)
nn.times do |i|
  j = ans[i]
  next if j < 0
  mask, arr = masks[i]
  k = 0
  nmask = mask << j
  n.times do |l|
    if nmask.bit(l) == 1
      a[arr[k]] = l + 1
      k += 1
    end
  end
end

puts a.join(" ")



