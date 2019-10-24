N = gets.to_i
S = gets.chomp.split(//)

E = S.grep("E").size
W = S.grep("W").size

EAST = 0
WEST = 1

LEFT = [0,0]
LEADER = S[0] == "E" ? [1,0] : [0,1]

1..