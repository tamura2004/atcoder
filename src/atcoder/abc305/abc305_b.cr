D = "A..BC...DE....F........G"
p, q = gets.to_s.split

ans = (D.index(p).not_nil! - D.index(q).not_nil!).abs
pp ans