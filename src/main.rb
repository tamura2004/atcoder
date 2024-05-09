s = "(" + gets.chomp + ")"
a = s.chars.map do |c|
  case c
  when "a".."z", "A".."Z"
    '"' + c + '"'
  when "("
    "["
  else
    "]"
  end
end.to_a.join(" ")
.gsub('" "', '","')
.gsub('] "', '],"')
.gsub('" [', '",[')
b = eval(a)

ans = []

rev = -> c do
  case c
  when "a".."z"
    c.upcase
  else
    c.downcase
  end
end

dfs = -> (v, depth) do
  case v
  when String
    if depth.odd?
      ans << v
    else
      ans << rev[v]
    end
  else
    if depth.even?
      v.each do |nv|
        dfs[nv, depth + 1]
      end
    else
      v.reverse_each do |nv|
        dfs[nv, depth + 1]
      end
    end
  end
end

dfs[b, 0]
puts ans.join