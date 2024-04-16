# メモ化再帰

n = gets.to_s.to_i

memo = {} of Int32 => Int32
solve = uninitialized Proc(Int32, Int32)
solve = ->(money : Int32) {
  return 0 if money.zero?
  return memo[money] if memo.has_key?(money)
  ret = Int32::MAX
  [6, 9].each do |unit|
    (1..7).each do |k|
      break if money < unit ** k
      chmin ret, solve.call(money - unit ** k) + 1
    end
  end
  chmin ret, money
  memo[money] = ret
}

ans = solve.call(n)
pp ans