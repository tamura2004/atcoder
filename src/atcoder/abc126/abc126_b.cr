s = gets.to_s

mae = s[0,2]
ato = s[2,2]
tuki = %w(01 02 03 04 05 06 07 08 09 10 11 12)

case
when mae.in?(tuki) && ato.in?(tuki) then puts "AMBIGUOUS"
when mae.in?(tuki) && !ato.in?(tuki) then puts "MMYY"
when !mae.in?(tuki) && ato.in?(tuki) then puts "YYMM"
when !mae.in?(tuki) && !ato.in?(tuki) then puts "NA"
end