# 深さの偶奇で順序が変わるDFS

require "crystal/graph"

s = "@" + gets.to_s
n = s.size
g = n.to_g
root = 0
st = [root]

n.times do |i|
  next if i.zero?
  case s[i]
  when '('
    g.add st[-1], i, origin: 0, both: false
    st << i
  when ')'
    st.pop
  else
    g.add st[-1], i, origin: 0, both: false
  end
end

def rev(c)
  case c
  when /[a-z]/
    ('A'.ord + c.ord - 'a'.ord).chr
  else
    ('a'.ord + c.ord - 'A'.ord).chr
  end
end


def rev(c)
  case c
  when 'a'..'z'
    c.upcase
  else
    c.downcase
  end
end

ans = [] of Char
dfs = uninitialized Proc(Int32, Int32, Nil)
dfs = -> (v : Int32, depth : Int32) do
  if s[v] != '(' && s[v] != '@'
    if depth.odd?
      ans << s[v]
    else
      ans << rev(s[v])
    end
  else
    if depth.odd?
      g.each(v) do |nv|
        dfs.call(nv, depth + 1)
      end
    else
      g.reverse_each(v) do |nv|
        dfs.call(nv, depth + 1)
      end
    end
  end
end

dfs.call(0, 0)
puts ans.join.reverse