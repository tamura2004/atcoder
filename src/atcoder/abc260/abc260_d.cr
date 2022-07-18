require "crystal/balanced_tree/treap/multiset"

st = Multiset(Int32).new

n, k = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i.pred)

quit a.zip(0..).sort.map(&.last.succ).join("\n") if k == 1

ln = Array.new(n, -1)
cnt = Array.new(n, 0)
ans = Array.new(n, -1)

a.each_with_index do |v, i|
  if nv = st.upper(v)
    ln[v] = nv
    cnt[v] = cnt[nv] + 1

    st << v
    st.delete nv

    if cnt[v] >= k
      st.delete v
      ans[v] = i + 1 # 0-origin

      while nv != -1
        ans[nv] = i + 1 # 0-origin
        nv = ln[nv]
      end
    end
  else
    st << v
    cnt[v] = 1
  end
end

puts ans.join("\n")