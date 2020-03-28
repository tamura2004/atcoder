
def solve(n,k,m,r,s)
  # すでに合格か、最終が０点でも合格
  if s[0,k].inject(0,:+) >= k * r
    return 0
  else

    # 未確定の場合
    # 確定の上位k-1個（全部かも）の合計を、k*rから引き、borderとする
    # borderがmを超えるなら、もはや合格できない、-1とする
    # それ以外ならborderが答え

    border = k * r - s[0,k-1].inject(0,:+)
    return border > m ? -1 : border
  end
end

def other(n,k,m,r,s)
  s << 0
  # k < n かつ、すでに合格
  if k < n && s[0,k].inject(0,:+) >= k * r
    return 0
  else
  
    # 未確定の場合
    # 確定の上位k-1個（全部かも）の合計を、k*rから引き、borderとする
    # borderがmを超えるなら、もはや合格できない、-1とする
    # それ以外ならborderが答え
  
    border = k * r - s[0,k-1].inject(0,:+)
    return border > m ? -1 : border
  end
end

100.times do
  n = rand(100) + 1
  k = rand(n) + 1
  m = rand(10**9) + 1
  r = rand(m) + 1
  s = Array.new(n-1){ rand(m+1) }

  want = solve(n,k,m,r,s)
  got = other(n,k,m,r,s)
  if want != got
    p [want, got]
    p [n,k,m,r,s]
    exit
  end
end

puts "no difference detected."