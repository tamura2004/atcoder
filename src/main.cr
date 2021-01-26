macro chmin(target, other)
  {{target}} = ({{other}}) if ({{target}}) > ({{other}})
end

n = gets.to_s.to_i
s = Array.new(n){ gets.to_s.to_p }
up = s.select{|min,tot|tot > 0}
down = s.select{|min,tot|tot <= 0}

up.sort_by! do |min,tot|
  {-min, tot}
end

down.sort_by! do |min,tot|
  {min-tot,-tot}
end

# pp! up
# pp! down

cnt = 0
(up + down).each do |min,tot|
  if cnt + min < 0
    puts "No"
    exit
  end
  cnt += tot
end
if cnt != 0
  puts "No"
else
  puts "Yes"
end

class String
  def to_p
    min = tot = 0
    chars.each do |c|
      case c
      when '('
        tot += 1
      when ')'
        tot -= 1
        chmin min, tot
      end
    end
    return ({min,tot})
  end
end

# pp! ")".to_p