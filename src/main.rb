ans = []
ans += (?a..?z).to_a.sample(4)
ans += (?0..?9).to_a.sample(4)
ans += (?A..?Z).to_a.sample(4)
ans += (?0..?9).to_a.sample(4)
puts ans.join
