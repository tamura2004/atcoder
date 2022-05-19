fib = ->n do
  case n
  when 1 then 1
  when 2 then 1
  else fib[n - 1] + fib[n - 2]
  end
end

pp fib[10]
