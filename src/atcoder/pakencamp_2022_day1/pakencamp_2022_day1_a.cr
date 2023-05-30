ans = gets.to_s.split.map(&.to_i64.zero?.!.to_unsafe).sum
pp ans
