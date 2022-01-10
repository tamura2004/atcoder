require "json"

fn = %w(big samll red blue green yellow gold silver black white awesome wonderful silly pretty most great invisible running walking jumping slimy greedy honest goodman badguy hot cold cool)

gn = %w(adam bob clis dave emma frank george hans ivan josef king lemmon mermaid ninbus orphen pike quick ringo sam tom uruk vim wolf xenon yasu zebra)

customers = []
100.times do
  customer = {}
  customer[:name] = [fn.sample, gn.sample].join(" ")
  customer[:id] = rand(90000) + 10000
  customer[:age] = rand(100)

  customer[:accounts] = []
  rand(10).times do
    account = {}
    account[:type] = %w(a b c d).sample
    account[:number] = rand(1000)
    account[:qtty] = rand(10000000)
    customer[:accounts] << account
  end

  customers << customer
end

puts JSON.pretty_generate(customers)
