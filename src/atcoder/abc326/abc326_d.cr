n = gets.to_s.to_i64
ro = gets.to_s.chars
co = gets.to_s.chars

(0...n).to_a.each_permutation do |a|
  (0...n).to_a.each_permutation do |b|
    next if a.zip(b).any? { |x, y| x == y }
    (0...n).to_a.each_permutation do |c|
      next if a.zip(c).any? { |x, y| x == y }
      next if b.zip(c).any? { |x, y| x == y }

      ans = make_array('.', n, n)
      n.times do |y|
        ans[y][a[y]] = 'A'
        ans[y][b[y]] = 'B'
        ans[y][c[y]] = 'C'
      end

      row = Array.new(n, '.')
      n.times do |y|
        mini = [a[y], b[y], c[y]].min
        case mini
        when a[y] then row[y] = 'A'
        when b[y] then row[y] = 'B'
        when c[y] then row[y] = 'C'
        end
      end

      col = Array.new(n, '.')
      n.times do |y|
        if col[a[y]] == '.'
          col[a[y]] = 'A'
        end

        if col[b[y]] == '.'
          col[b[y]] = 'B'
        end

        if col[c[y]] == '.'
          col[c[y]] = 'C'
        end
      end

      if row == ro && col == co
        puts :Yes
        puts ans.map(&.join).join("\n")
        exit
      end
    end
  end
end

puts "No"
