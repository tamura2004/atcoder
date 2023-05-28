A = "atcoder".chars

s = gets.to_s
t = gets.to_s

sa = Hash(Char,Int64).new(0_i64)
ta = Hash(Char,Int64).new(0_i64)

so = [] of Char
to = [] of Char

sn = 0_i64
tn = 0_i64

s.chars.each do |c|
  case c
  when '@'
    sn += 1
  when 'a','t','c','o','d','e','r'
    sa[c] += 1
  else
    so << c
  end
end

t.chars.each do |c|
  case c
  when '@'
    tn += 1
  when 'a','t','c','o','d','e','r'
    ta[c] += 1
  else
    to << c
  end
end

so.sort!
to.sort!

if so != to
  quit :No
end

['a','t','c','o','d','e','r'].each do |c|
  if sa[c] == ta[c]
  elsif sa[c] > ta[c]
    tn -= sa[c] - ta[c]
    quit :No if tn < 0
  else
    sn -= ta[c] - sa[c]
    quit :No if sn < 0
  end
end

puts "Yes"
# pp [0,0,1,2] - [0,1,2]

# s = gets.to_s.chars.sort.reverse
# t = gets.to_s.chars.sort.reverse

# n = s.count('@')
# m = t.count('@')

# while s.size > 0 && s[-1] == '@'
#   s.pop
# end

# while t.size > 0 && t[-1] == '@'
#   t.pop
# end

# loop do
#   if s.size == 0 || t.size == 0
#     quit :Yes
#   else
#     if s[-1] == t[-1]
#       s.pop
#       t.pop
#     elsif s[-1] < t[-1]
#       quit :No if !s[-1].in?("a","t","c","o","d","e","r")
#       s.pop
#       m -= 1
#       quit :No if m < 0
#     elsif s[-1] > t[-1]
#       quit :No if !t[-1].in?("a","t","c","o","d","e","r")
#       t.pop
#       n -= 1
#       quit :No if n < 0
#     end
#   end
# end


