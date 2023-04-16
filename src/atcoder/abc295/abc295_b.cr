r, c = gets.to_s.split.map(&.to_i64)
g = Array.new(r){gets.to_s.chars}
ans = Array.new(r){Array.new(c, '#')}

r.times do |y|
  c.times do |x|
    if g[y][x] != '#'
      ans[y][x] = '.'
    else
      r.times do |ty|
        c.times do |tx|
          if g[ty][tx].in?('1'..'9')
            bomb = g[ty][tx].to_i
            if (x-tx).abs + (y-ty).abs <= bomb
              ans[y][x] = '.'
            end
          end
        end
      end
    end
  end
end

puts ans.map(&.join).join("\n")



