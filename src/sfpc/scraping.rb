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
  html = open("https://atcoder.jp/users/#{user}").read
  doc = Nokogiri::HTML.parse(html)
  info = doc.css("tr").map{ |tr| tr.css("th,td").map(&:text) }.to_h
  info["user"] = user
  info["Rating"].gsub!(/[\t\n]/,"") if info["Rating"]
  if info["Rank"]
    info["Rank"] = info["Rank"].gsub(/th/,"").to_i
  else
    info["Rank"] = 999999
  end
  info["Highest Rating"] = info["Highest Rating"]&.split(/\n/)[1].gsub(/[\t\n]/,"") if info["Highest Rating"]
  data << info
end

data.sort_by!{|v|v["Rank"]}

open("users_rank.json","w") do |fh|
  fh.puts data.to_json
  puts data.to_json
end
