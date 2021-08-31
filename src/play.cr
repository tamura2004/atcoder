a = [1, 2, 3, 4]
b = a.zip(0..).select(&.last.odd?).map(&.first)
pp b
