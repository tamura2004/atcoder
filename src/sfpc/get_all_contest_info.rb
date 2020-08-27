CONTEST_IDS = %w[
  ec4b5aff-acc3-4703-98e2-c801d885a9f2
  8479fa06-4ce0-4dfd-9db2-bf6f2d775301
  e7e096cc-2367-4db5-9772-f764c4776baa
  51947ba4-a626-4f0b-81a3-1bf0ad00df39
  ce8eb5f0-6cb0-4d87-a9ac-8cbbe0d84150
  c4acae5b-d0c7-4544-9fd8-12d6762c6b73
  2ebfdaaa-81aa-41b7-8f17-da9068a36552
  b819e60f-7b7a-4885-9ff9-a23bfb68be8d
  47df9501-a884-4e7c-8be8-22ce29eea819
  854432ee-5318-48f4-ad9c-b0317bc04443
  ffb9ce1c-81d6-4fb4-8681-60aa4a4ef90e
  ee459d54-1c68-441c-9e52-d06174e3e941
  f0756d79-0e54-40f7-9944-c31ae9d1b2c7
  d77f7283-828f-411b-ac8e-212c4a67f6b9
  7861190d-8177-4581-8310-5989ba8f09e4
  c8979f4e-5319-49a1-ac7f-65fff85ade5e
  16774180-faf8-4b00-a63f-7c94e6290ac9
  aaeacbec-113e-4361-8c54-ebd676bdd5da
  bc20848c-eb04-4953-a018-f2dc3034632d
  55263904-03d8-424a-a11a-d62fd2121a3a
  21695e08-a175-4fa6-ba44-3c9bac6e2172
  7967779c-f7b8-43f9-bcbb-1022cd9b49a3
]

# curl 'https://kenkoooo.com/atcoder/internal-api/contest/get/bc20848c-eb04-4953-a018-f2dc3034632d' \
#   -H 'authority: kenkoooo.com' \
#   -H 'pragma: no-cache' \
#   -H 'cache-control: no-cache' \
#   -H 'accept: application/json' \
#   -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36' \
#   -H 'content-type: application/json' \
#   -H 'sec-fetch-site: same-origin' \
#   -H 'sec-fetch-mode: cors' \
#   -H 'sec-fetch-dest: empty' \
#   -H 'referer: https://kenkoooo.com/atcoder/' \
#   -H 'accept-language: ja,en-US;q=0.9,en;q=0.8' \
#   -H 'cookie: token=d45b3b16083d71a523877d002bfbfc36dae7d889' \
#   --compressed ;

require "open-uri"
require "json"

# id = "ec4b5aff-acc3-4703-98e2-c801d885a9f2"
CONTEST_IDS.each do |id|
  url = "https://kenkoooo.com/atcoder/internal-api/contest/get/#{id}"

  json = URI.open(url,
    # "authority" => "kenkoooo.com",
    # "pragma" => "no-cache",
    "accept" => "application/json",
    "content-type" => "application/json",
    "sec-fetch-site" => "same-origin",
    "sec-fetch-mode" => "cors",
    "sec-fetch-dest" => "empty",
    # "referer" => "https://kenkoooo.com/atcoder",
    # "accept-language" => "ja,en-US;q=0.9,en;q=0.8",
    # "cookie" => "token=d45b3b16083d71a523877d002bfbfc36dae7d889'"
  ).read

  info = JSON.parse(json)
  title = info["info"]["title"].gsub(/[\s#]*/,"")
  # title = "testrun"

  open("src/sfpc/contests/#{title}.json", "w") do |fh|
    fh.puts JSON.pretty_generate(info)
    puts JSON.pretty_generate(info)
  end
  # exit
  sleep 3
end
