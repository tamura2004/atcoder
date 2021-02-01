def upper_bound(a,x)
  a.reverse.bsearch do |v|
    x >= v
  end
end

a = [0,3,5,7,9]
pp upper_bound(a,1)
