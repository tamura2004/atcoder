names = [
  {
    name: "もねた",
    branches: [
      "ふたご",
      "れちくる",
      "てんびん",
    ],
  },
  {
    name: "かりす",
    branches: [
      "おひつじ",
      "おうし",
      "かに",
    ],
  },
  {
    name: "きるけ",
    branches: [
      "しし",
      "おとめ",
      "さそり",
    ],
  },
  {
    name: "てみす",
    branches: [
      "みずがめ",
      "うお",
      "みなみのさんかく",
    ],
  },
  {
    name: "ぽぽす",
    branches: [
      "いて",
      "やぎ",
      "らしんばん",
    ],
  },
  {
    name: "もねたカード",
    branches: [
      "もねたカード",
    ],
  },
]

bankd = {}
branch = {}
branch_id = 0

names.each_with_index do |bank, id|
  bankd["100#{id}"] = {
    "bango" => "100#{id}",
    "kanji_name" => bank[:name] + (bank[:name] =~ /カード/ ? "" : "銀行"),
    "kana_name" => bank[:name],
  }

  bank[:branches].each_with_index do |name, i|
    branch_id += 1
    key = (100 + branch_id).to_s
    branch[key] = {
      "bank_bango" => "100#{id}",
      "shiten_bango" => key,
      "kanji_name" => name + (name =~ /カード/ ? "" : "座支店"),
      "nama_name" => name,
    }
  end
end

open("bank.rb", "w") do |fh|
  fh.puts bankd.inspect
end

open("branch.rb", "w") do |fh|
  fh.puts branch.inspect
end
