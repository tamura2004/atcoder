n, t, m = gets.to_s.split.map(&.to_i)
hate = Array.new(n) { Set(Int32).new }

m.times do
  a, b = gets.to_s.split.map(&.to_i.pred)
  hate[a] << b
  hate[b] << a
end

state = [] of Set(Int32)

solve = uninitialized Proc(Int32, Int32)
solve = ->(i : Int32) do
  return 0 if t < state.size
  if i == n
    return state.size == t ? 1 : 0
  end

  cnt = 0
  state.size.times do |j|
    next if hate[i].intersects?(state[j])

    state[j] << i
    cnt += solve.call(i + 1)
    state[j].delete(i)
  end
  state << Set{i}
  cnt += solve.call(i + 1)
  state.pop
  return cnt
end

pp solve.call(0)
