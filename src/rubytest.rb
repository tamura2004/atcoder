a = DATA.read.split(/^\n+/)
a.each_slice(2) do |query,want|

    io = IO.popen("ruby src/main.rb", "w+")
    io.puts query
    io.close_write
    ans = io.read
    
    puts "-"*80
    if ans != want
        puts "WA: want:#{want}, got:#{ans}"
    else
        puts "AC"
    end
end

__END__
ABBABBABAB
BA

Yes

ABCGBGBG
BGB

Yes

ABCDCFG
AFH

No
