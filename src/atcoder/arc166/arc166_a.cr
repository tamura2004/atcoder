# yをCで区切って連結成分に分ける
# 連結成分ごとのA,Bの個数を数える
# xの対応する連結成分のA,Bの個数がyの対応する連結成分のA,Bの個数より多い場合、不可
# それ以外の場合、辞書順で小さければYes

y = "CAAABACCCACAB"
x = "AACCBACCCACAB"

solve = -> (n : Int64, x : String, y : String) do
  cnt = y.chars.zip(x.chars).chunks do |yc, xc|
    yc == 'C'
  end

  cnt.each do |(is_c, arrs)|
    if is_c
      if !arrs.all?(&.[1].== 'C')
        return :No
      end
    else
      yarr, xarr = arrs.transpose
      
      ya = yarr.count('A')
      yb = yarr.count('B')
      xa = xarr.count('A')
      xb = xarr.count('B')

      return :No if xa > ya || xb > yb

      xarr.each_index do |i|
        next if xarr[i] != 'C'
        if ya - xa > 0
          xarr[i] = 'A'
          xa += 1
        else
          xarr[i] = 'B'
          xb += 1
        end
      end

      if xarr > yarr
        return :No
      end
    end
  end
  :Yes
end



t = gets.to_s.to_i64
t.times do
  n, x, y = gets.to_s.split
  n = n.to_i64
  puts solve.call(n, x, y)
end
