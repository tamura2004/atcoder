H,W = gets.split.map(&:to_i)
S = H.times.map{gets.chomp}
D = Array.new(H){Array.new(W){nil}}

X = Y = [-1,0,1]

H.times do |h|
  W.times do |w|
    if S[h][w] == "#"
      D[h][w] = "#"
      next
    end

    count = 0
    X.each do |x|
      Y.each do |y|
        ww = w + x
        hh = h + y
        next if ww < 0 || W <= ww
        next if hh < 0 || H <= hh
        count += 1 if S[hh][ww] == "#"
      end
    end
    D[h][w] = count
  end
end

H.times do |h|
  puts D[h].join
end

