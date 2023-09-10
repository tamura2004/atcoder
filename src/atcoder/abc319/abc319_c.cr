c=`dd`.split
d="JCYHSZJYdgKxM".to_i128(62).digits.in_slices_of 3
p 1-((0..8).to_a.permutations.count{|o|d.any? &.permutations.any?{|(x,y,z)|c[x]==c[y]&&o[x]<o[y]<o[z]}})/362880