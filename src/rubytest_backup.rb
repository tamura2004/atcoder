# class String
#     def colorize(color_code)
#         "\e[#{color_code}m#{self}\e[0m"
#     end
#     def red; colorize(31); end
#     def green; colorize(32); end
#     def yellow; colorize(33); end
# end

a = DATA.read.split(/^n+/)
p a
exit
# puts a.join.red
# puts a.join.green
# exit

require "tomlrb"

good = true
cases = Tomlrb.load_file("src/testcase.toml", symbolize_keys: true)

cases[:testcase].each_with_index do |h,i|
    k = h[:in]
    v = h[:out]
        
    io = IO.popen("ruby src/main.rb", "w+")
    io.puts k
    io.close_write
    ans = io.read

    puts "---- case[#{i+1}]"
    if ans != v
        puts "bad #{k}. want:#{v}, got:#{ans}"
    else
        puts "good #{k}"
    end
end
__END__
# 学生がいないので誰も通過しない

6 1 1
cc

No
No

# 全員国内の学生

2 1 1
aa

Yes
Yes