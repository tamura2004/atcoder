date = Time.parse(gets.to_s, "%Y/%m/%d", Time::Location::UTC)

loop do
  if date.to_s("%Y%m%d").chars.uniq.size <= 2
    quit date.to_s("%Y/%m/%d")
  else
    date = date + 1.day
  end
end
