open "snippet.txt", "w" do |fh|
  1.upto(4) do |i|
    (1 << i).times do |s|
      types = []
      tname = []
      abb = []

      i.times do |j|
        if s[j] == 1
          types << "Int32"
          tname << "int"
          abb << "i"
        else
          types << "Int64"
          tname << "long"
          abb << "l"
        end
      end

      fh.puts "\t\"type proc #{tname.join(" ")}\": {"
      fh.puts "\t\t\"prefix\": \"p#{abb.join}\","
      fh.puts "\t\t\"body\" : ["
      fh.puts "\t\t\t\"Proc(#{types.join(",")})\","
      fh.puts "\t\t]"
      fh.puts "\t},"
    end
  end
end
