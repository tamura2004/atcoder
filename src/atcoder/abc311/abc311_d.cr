# キューに（位置、方向）を積んでBFS
# 方向には4方向に加え、停止を含む
# 停止の場合は4方向が選択肢
# そうでなければ、方向変えない

enum D
  Up
  Down
  Left
  Right
  Stop
end

h, w = gets.to_s.split.map(&.to_i64)
g = Array.new(h){ gets.to_s }

q = Deque.new([{1,1,D::Stop}])
seen = Array.new(h){
  Array.new(w){
    Set(D).new
  }
}
seen[1][1] << D::Stop

while q.size > 0
  y, x, dir = q.shift
  [{-1,0,D::Up},{1,0,D::Down},{0,1,D::Right},{0,-1,D::Left}].each do |dy,dx,ndir|
    next unless dir.stop? || dir == ndir
    ny = y + dy
    nx = x + dx
    if g[ny][nx] == '#' && !dir.stop?
      q << {y, x, D::Stop}
    end
    next if g[ny][nx] == '#'
    next if ndir.in?(seen[ny][nx])
    seen[ny][nx] << ndir
    q << {ny, nx, ndir}
  end
end

pp seen.sum(&.count{ |s| !s.empty? })