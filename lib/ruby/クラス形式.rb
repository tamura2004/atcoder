class Problem
    attr_reader :h,:w,:a
  
    DX = [1,0,-1,0]
    DY = [0,1,0,-1]
  
    
    def initialize(&block)
      @h,@w = get_array
      @a = Array.new(h) { get_array }
      self.instance_eval(&block)
    end
    
    def bfs(x,y)
      return 0 if @a[y][x].even?
      ans = 1
      que = [[x,y]]
      while !que.empty?
        px,py = que.shift
        4.times do |i|
          nx = px + DX[i]
          ny = py + DX[i]
          next unless within(nx,ny)
          next unless @a[ny][nx].odd?
          ans += 1
          @a[ny][nx] = 0
          que << [nx,ny]
        end
      end
      return ans
    end
  
    def solve
      ans = 0
      @h.times do |y|
        @w.times do |x|
          cnt = bfs(x,y)
          cnt -= 1 if cnt.odd?
          ans += cnt
        end
      end
      return ans
    end
  
    private
  
    def get_array
      gets.split.map &:to_i
    end
  
    def within(x,y)
      0 <= x && x < @w && 0 <= y && y < @h
    end
  end
  
  Problem.new do
    puts solve
  end
  