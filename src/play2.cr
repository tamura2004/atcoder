fib = uninitialized Proc(Int32,Int32)
fib = -> (n : Int32) do
  case n
  when 1 then 1
  when 2 then 1
  else fib.call(n - 1) + fib.call(n - 2)
  end
end

pp fib.call(10) # Error: can't use variable name 'fib' inside assignment to variable 'fib'
