def solve(n, s)
  case s
  when /I.*J.*P.*C/
    0
  when /.+J.*P.*C/
    1
  when /I.*J.+C/
    1
  when /I.+P.*C/
    1
  when /I.*J.*P.+/
    1
  when /.{2}P.*C/
    2
  when /I.{2}C/
    2
  when /I.*J.{2}/
    2
  when /I.+P.+/
    2
  when /.+J.+C/
    2
  when /.{3}C/
    3
  when /.{2}P.+/
    3
  when /.+J.{2}/
    3
  when /I.{3}/
    3
  else
    4
  end
end

n = gets.to_s.to_i
s = gets.chomp
puts solve(n, s)
