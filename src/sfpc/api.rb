require "json"
require "nokogiri"
require "open-uri"

users = %w[
  deltazarashi
  hosonuma
  hyuu
  ibyoneyama
  kamiryo
  KanaeTsukimitsu
  loveflower
  MiCHiN
  NakatsukaMomoka
  namba1997
  okakita
  RinkaSasagawa
  ShuHONDA
  takanoyuto
  tamura2004
  yamamichi
  yanai
  yuichiyoshida
  yukakawamoto
  ZatoZatoYuki
]

data = []
users.each do |user|
  url = "https://kenkoooo.com/atcoder/atcoder-api/results?user=#{user}"
  json = URI.open(url).read
  data.push(JSON.parse(json))
end

open("src/sfpc/users.json", "w") do |fh|
  fh.puts data.to_json
end
