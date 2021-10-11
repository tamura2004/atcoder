n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i.- 1)

ans = [] of Int32
while (i = solve(a))
  ans << i
end

if a.size > 0
  pp -1
else
  puts ans.reverse.map(&.succ).join("\n")
end

def solve(a)
  n = a.size

  (n-1).downto(0) do |i|
    if a[i] == i
      return a.delete_at(i)
    end
  end

  return nil
end
