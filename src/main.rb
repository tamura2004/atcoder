_,a,b=*$<.map{_1.split.map &:to_i}
puts a.zip(b).map{_1*_2}.sum==0?:Yes:"No"
