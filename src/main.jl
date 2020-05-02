function main()
  n = parse(Int, readline())
  a = map(readlines()) do s
    map(split(s)) do c
      parse(Int, c)
    end
  end
  cnt = Dict{Vector{Int},Int}()
  for i in 1:n
    cnt[a[i]] = 1
  end
  L = [0 -1; 1 0]
 
  ans = 0
  for i in a, j in a
    if i[1] <= j[1]
      v = L * (j - i)
      if haskey(cnt, i + v) && haskey(cnt, j + v)
        res = v[1]^2 + v[2]^2
        if res > ans
          ans = res
        end
      end
    end
  end
 
  println(ans)
end
 
main()