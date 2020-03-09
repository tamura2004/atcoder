n = gets.to_i
1.upto(3500) do |x|
  1.upto(3500) do |y|
    nume = n*x*y
    deno = 4*x*y - n*x - n*y
    if deno > 0 && nume % deno == 0
      z = nume / deno
      puts [x, y, z].join(" ")
      exit
    end
  end
end

