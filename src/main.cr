n = gets.to_s.to_i64
s = gets.to_s

quit 0 if s =~ /UTPC/
quit 1 if s =~ /UTP./
quit 1 if s =~ /UT.C/
quit 1 if s =~ /U.PC/
quit 1 if s =~ /.TPC/
quit 2 if s =~ /..PC/
quit 2 if s =~ /.T.C/
quit 2 if s =~ /.TP./
quit 2 if s =~ /U..C/
quit 2 if s =~ /U.P./
quit 2 if s =~ /UT../
quit 3 if s =~ /U.../
quit 3 if s =~ /.T../
quit 3 if s =~ /..P./
quit 3 if s =~ /...C/
puts 4