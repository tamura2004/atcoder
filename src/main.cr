def hoge(T)(params) : [] of T
  ans = [] of T
  params.each do |v|
    ans << v
  end
end

pp hoge(Ibt32)([1,2,3,4])