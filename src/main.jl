n,k = [parse(Int, x) for x in readline() |> split]
a = [parse(Int, x) for x in readline() |> split]
m = zeros(Int,n,n)
for i in 1:n
  m[a[i],i] = 1
end

ans = m ^ k

for i in 1:n
  if ans[i,1] == 1
    println(i)
    exit()
  end
end

