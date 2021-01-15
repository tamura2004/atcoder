require "json"

Record = Struct.new(:title, :user_id, :score, :start_time, :end_time, :duration)

def get_json(path)
  json = open(File.join(__dir__, path)).read
  JSON.parse(json)
end

def get_info(n)
  name = "SFPC%03d" % n
  path = "contests/#{name}.json"
  get_json(path)
end

def get_score(n)
  name = "SFPC%03d" % n
  path = "scores/#{name}_scores.json"
  get_json(path)
end

def hms(sec)
  s = sec % 60
  sec /= 60
  m = sec % 60
  sec /= 60
  h = sec
  "%4d:%02d:%02d" % [h, m, s]
end

fh = open("all_scores.csv", "w")
users = get_json("users.json")
22.times do |i|
  id = i + 1
  printf("SFPC%03d\n", id)
  info = get_info(id)
  scores = get_score(id)
    .sort! { |a, b| a["epoch_second"] <=> b["epoch_second"] }
    .select { |rec| rec["result"] == "AC" }
  problems = info["problems"]
  n = problems.size
  recs = []

  users.each do |user|
    user_scores = scores.select { |rec| rec["user_id"] == user }
    rec = Record.new("SFPC%03d" % id, user, 0, 0, 0)

    problems.each do |problem|
      # if problem["order"] == 0
      score = user_scores.find do |s|
        s["problem_id"] == problem["id"]
      end
      next if score.nil?

      rec.score += 1
      rec.start_time = score["epoch_second"] if score["epoch_second"] < rec.start_time || rec.start_time == 0
      rec.end_time = score["epoch_second"] if score["epoch_second"] > rec.end_time || rec.end_time == 0

      # else
      #   score = user_scores.find do |s|
      #     s["problem_id"] == problem["id"] &&
      #     rec.start_time <= s["epoch_second"]
      #   end

      #   next if score.nil?

      #   rec.score += 1
      # end

    end

    rec.duration = hms(rec.end_time - rec.start_time)
    rec.start_time = Time.at(rec.start_time).strftime("%D %T")
    rec.end_time = Time.at(rec.end_time).strftime("%D %T")
    recs << rec
  end

  recs.sort! do |a, b|
    (b.score <=> a.score).nonzero? ||
    (a.duration <=> b.duration)
  end

  recs.each_with_index do |rec, i|
    fh.puts ([i + 1] + rec.to_a).join(",")
  end
end

fh.close
