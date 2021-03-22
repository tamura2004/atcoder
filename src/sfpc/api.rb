require "json"
require "nokogiri"
require "open-uri"

users = %w[
  yamamichi
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

# iaduf123
# MasahiroTada108
# zukeyama0424
# kohara1213
# nakamuraemiko
# kohara1213
# zukeyama0424
# yanai
# loveflower
# okakita
# ShuHONDA
# ZatoZatoYuki
# namba1997
# KanaeTsukimitsu
# yuichiyoshida
# RinkaSasagawa
# takanoyuto
# deltazarashi
# yukakawamoto
# hosonuma
# NakatsukaMomoka
# hyuu
# ibyoneyama
# kamiryo
# MiCHiN
# tamura2004