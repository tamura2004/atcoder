# enum使ってみる
enum Weather
  Sunny
  Cloudy
  Rainy
end

w = Weather.parse(gets.to_s)
ans = Weather.from_value((w.value + 1) % 3)
pp ans
