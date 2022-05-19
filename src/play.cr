require "csv"

cnt = {} of String => Tuple(Int32, String, String, String)

File.open("/home/tamura/src/submissions.csv") do |f|
  csv = CSV.new(f, headers: true)
  csv.each do |(_, _, problem_id, contest_id, user_id, language, point, length, result, _)|
    next if result != "AC"
    next if cnt.has_key?(problem_id) && cnt[problem_id][0] <= length.to_i
    cnt[problem_id] = {length.to_i, language, point, user_id}
  end
end

ans = CSV.build do |csv|
  cnt.each do |problem_id, (length, language, point,user_id)|
    csv.row [language, problem_id, length, point, user_id]
  end
end

File.open("/home/tamura/src/shortest.csv", "w") do |f|
  f.puts "language, problem_id, length, point, user_id"
  f.puts ans
end
# pp! cnt
puts `cat /home/tamura/src/shortest.csv`
