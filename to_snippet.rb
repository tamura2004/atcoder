open "snippet.txt", "w" do |fh|
  2.upto(4) do |i|
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

      fh.puts "\t\"type tuple #{tname.join(" ")}\": {"
      fh.puts "\t\t\"prefix\": \"t#{abb.join}\","
      fh.puts "\t\t\"body\" : ["
      fh.puts "\t\t\t\"Tuple(#{types.join(",")})\","
      fh.puts "\t\t]"
      fh.puts "\t},"
    end
  end
end
