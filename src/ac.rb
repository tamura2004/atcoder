n=gets.to_i
f=->b,i,m{
  if i==n
    puts b
    return
  end
  0.upto(m){|j| f[b+(97+j).chr,i+1,m] }
  f[b+(97+m+1).chr,i+1,m+1]
}
f["a",1,0]