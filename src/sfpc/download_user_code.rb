require "json"
require "fileutils"
require "nokogiri"
require "open-uri"

def get_json(path)
  json = open(File.join(__dir__, path)).read
  JSON.parse(json)
end

def download(contest_id, submission_id)
  sleep 2
  url = "https://atcoder.jp/contests/#{contest_id}/submissions/#{submission_id}"
  html = URI.open(url, &:read)
  doc = Nokogiri::HTML.parse(html,nil,"utf-8")
  doc.css(".linenums").first.children.text
end

users = get_json("users.json")
users.each do |user|
  user.each do |info|
    id,problem_id,contest_id,user_id,result = info.values_at("id","problem_id","contest_id","user_id","result",)
    next unless result == "AC"

    basedir = File.join("dist","sfpc",user_id)
    FileUtils.mkdir_p(basedir)

    src = download(contest_id, id)
    filename = File.join(basedir, problem_id + ".java")
    open(filename, "w") do |fh|
      fh.write(src)
    end

    puts filename
    STDOUT.flush
  end
end
