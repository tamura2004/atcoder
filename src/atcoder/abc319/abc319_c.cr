c=`dd`.split
p ([*0..8].permutations.count{|o|"JCYHSZJYdgKxM".to_u128(62).digits.in_slices_of(3).all? &.permutations.none?{|(x,y,z)|c[x]==c[y]&&o[x]<o[y]<o[z]}})/362880