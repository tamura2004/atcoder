aiueo = [
  "あかさたなはまやらわぱ",
  "いきしちちちちちにひみりぴ",
  "うくすつぬふむゆるうぷ",
  "えけせてねへめえれえぺ",
  "おこそとのほもよろをぽ",
]

ri = i = 2
rj = j = 5

1000.times do
  a = aiueo[0].split(//)[i]
  b = aiueo[1].split(//)[j]

  i *= ri
  i %= 11

  j *= rj
  j %= 9

  puts "#{a}#{b}#{b}ー"
end

p = 11
2.upto(10) do |i|
  ans = 1.upto(9).none? do |j|
    (i ** j) % 11 == 1
  end

  puts i if ans
end

7
4
1
