s=`dd`.lines
d=s.join.chars.uniq.join
d[10]?||[*0..9].each_permutation{|a|t=s.map &.tr d,a.join
i,j,k=t.map &.to_i64
t.min<"1"||i+j==k&&p(i,j,k)+exit}
puts :UNSOLVABLE