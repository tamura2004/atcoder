require "open-uri"
require "json"

22.times do |i|
  id = i + 1
  title = "SFPC%03d" % id
  filename = "src/sfpc/contests/%s.json" % title
  info = JSON.parse(open(filename).read)

  users = info["participants"].join(",")
  problems = info["problems"].map{|row|row["id"]}.join(",")
  from = info["info"]["start_epoch_second"]
  to = Time.now.to_i.to_s

  # pp info
  # pp users
  # pp problems
  # pp from
  # pp to

  url = "https://kenkoooo.com/atcoder/atcoder-api/v3/users_and_time?users=#{users}&problems=#{problems}&from=#{from}&to=#{to}"
  # pp url

  json = URI.open(url,
    "accept" => "application/json",
    "content-type" => "application/json",
    "sec-fetch-site" => "same-origin",
    "sec-fetch-mode" => "cors",
    "sec-fetch-dest" => "empty",
  ).read

  scores = JSON.parse(json)
  # pp JSON.pretty_generate(JSON.parse(json))

  open("src/sfpc/scores/#{title}_scores.json", "w") do |fh|
    fh.puts JSON.pretty_generate(scores)
    puts JSON.pretty_generate(scores)
  end
  pp "-" * 80
  pp title
  sleep 3
  # exit
end


# curl 'https://kenkoooo.com/atcoder/atcoder-api/v3/users_and_time?users=ShuHONDA,deltazarashi,takanoyuto,tamura2004,tomo22,yanai,yukakawamoto&problems=abc173_b,arc045_a,agc020_a,abc153_d,abc057_b,abc039_c,abc159_d,arc093_a,code_festival_qualA_c,codefestival_2015_qualB_c&from=1595941800&to=1598623800' \
#   -H 'authority: kenkoooo.com' \
#   -H 'pragma: no-cache' \
#   -H 'cache-control: no-cache' \
#   -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36' \
#   -H 'accept: */*' \
#   -H 'sec-fetch-site: same-origin' \
#   -H 'sec-fetch-mode: cors' \
#   -H 'sec-fetch-dest: empty' \
#   -H 'referer: https://kenkoooo.com/atcoder/' \
#   -H 'accept-language: ja,en-US;q=0.9,en;q=0.8' \
#   -H 'cookie: token=d45b3b16083d71a523877d002bfbfc36dae7d889' \
#   --compressed