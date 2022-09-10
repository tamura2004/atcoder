ev = [
  { x: 10, y: 20 },
  { x: 15, y: 25 },
]

ev.each do |t|
  pp [t[:x],t[:y]]
end