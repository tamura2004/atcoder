class Problem
  attr_accessor *(?a..?z).to_a.map(&:to_sym)
  def initialize
    @n = DATA.gets.to_s.to_i
    @a = Array.new(n){ DATA.gets.to_s.split }
  end

  def solve
    ans = []
    a.each do |rec|
      no,name,ante,post = rec
      sec = tosec(post) - tosec(ante)
      ans << [sec,name]
    end
    ans.sort
  end

  def tosec(timestring)
    h,m,s = timestring.split(/:/).map(&:to_i)
    h * 3600 + m * 60 + s
  end

  def tostr(sec)
    s = sec % 60
    sec /= 60
    m = sec % 60
    h = sec / 60
    sprintf("%02d:%02d:%02d", h, m, s)
  end

  def show(ans)
    ans.each do |sec,name|
      puts [name, tostr(sec)].join(" ")
    end
  end
end

Problem.new.instance_eval do
  show(solve)
end

__END__
11
2	ShuHONDA	6:57:10	19:02:42
3	okakita	6:24:27	26:26:49
4	loveflower	16:57:23	26:30:35
5	yanai	16:50:39	167:55:28
6	KanaeTsukimitsu	785:25:57	791:21:04
7	yuichiyoshida	784:50:55	791:25:27
8	RinkaSasagawa	808:39:17	813:30:26
9	yukakawamoto	808:33:10	814:56:46
10	takanoyuto	808:47:50	816:38:30
11	deltazarashi	808:49:58	817:47:40
12	NakatsukaMomoka	808:40:10	818:07:22
