hoge = Proc(Tuple(Int32,Int32),Int32).new do |(x,y)|
  x + y
end

pp hoge.call({1,2})