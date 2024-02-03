nums = (1..12).map {|i| ("1" * i).to_i64}
candi = nums.repeated_combinations(3).map(&.sum).to_set
ans = candi.to_a.sort
n = gets.to_s.to_i64.pred
pp ans[n]