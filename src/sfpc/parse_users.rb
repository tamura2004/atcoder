require "json"

def get_json(path)
  json = open(File.join(__dir__, path)).read
  JSON.parse(json)
end

num = Hash.new(0)
size = Hash.new(0)

users = get_json("users.json")
users.each do |user|
  user.each do |info|
    next unless info["result"] == "AC"
    key = info["user_id"]
    num[key] += 1
    size[key] += info["length"]
  end
end

num.keys.sort.each do |key|
  puts "#{key},#{num[key]},#{size[key]}"
end
