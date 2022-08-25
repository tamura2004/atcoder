module Printable
  abstract def each(&b : Int32 -> _)
  abstract def each(v : Int32, &b : Int32 -> _)

  # def print
  def to_s(io)
    # File.open("debug.dot", "w") do |fh|
    #   fh.puts "graph g {"
    each do |v|
      each(v) do |nv|
        io << "#{v} -> #{nv}\n"
        # fh.puts "\"#{v}\" -> \"#{nv}\";"
      end
    end
    #   fh.puts "}"
    # end
    # io << `cat debug.dot | graph-easy --from=dot --as_ascii`
  end

  def inspect(io)
    to_s(io)
  end
end
