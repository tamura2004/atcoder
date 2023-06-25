class Ps
  getter h : Int32
  getter w : Int32
  getter a : Array(Array(Int32))

  def initialize(@a)
    @h = a.size
    @w = a.first.size
  end

  def clip
    while a.size > 0 && a[-1].sum == 0
      a.pop
      @h -= 1
    end
    while a.size > 0 && a[0].sum == 0
      a.shift
      @h -= 1
    end
    while a.first.size > 0 && a.map(&.[0]).sum == 0
      a.map!(&.[1..])
      @w -= 1
    end
    while a.first.size > 0 && a.map(&.[-1]).sum == 0
      a.map!(&.[...w - 1])
      @w -= 1
    end
    self
  end
end

ha, wa = gets.to_s.split.map(&.to_i64)
a = Array.new(ha) { gets.to_s.chars.map(&.==('#').to_unsafe) }

hb, wb = gets.to_s.split.map(&.to_i64)
b = Array.new(hb) { gets.to_s.chars.map(&.==('#').to_unsafe) }

hx, wx = gets.to_s.split.map(&.to_i64)
x = Array.new(hx) { gets.to_s.chars.map(&.==('#').to_unsafe) }

psa = Ps.new(a).clip
psb = Ps.new(b).clip
psx = Ps.new(x).clip

ha, wa = psa.h, psa.w
hb, wb = psb.h, psb.w
hx, wx = psx.h, psx.w

# pp psa
# pp psb
# pp psx

# Xの内部でAを動かす
(0..(psx.h - psa.h)).each do |oay|
  (0..(psx.w - psa.w)).each do |oax|
    # Xの内部でBを動かす
    (0..(psx.h - psb.h)).each do |oby|
      (0..(psx.w - psb.w)).each do |obx|
        # 透明ワークシート作る
        wk = make_array(0, psx.h, psx.w)
        # aの点をプロット
        psa.h.times do |day|
          psa.w.times do |dax|
            begin
              wk[oay + day][oax + dax] |= a[day][dax]
            rescue
              pp! [oay, day, oax, dax]
              exit
            end
          end
        end
        # bの点をプロット
        psb.h.times do |dby|
          psb.w.times do |dbx|
            wk[oby + dby][obx + dbx] |= b[dby][dbx]
          end
        end
        if psx.a == wk
          quit :Yes
        end
      end
    end
  end
end

puts "No"
