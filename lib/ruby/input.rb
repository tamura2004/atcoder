def r;gets.split.map &:to_i;end
def rd;gets.split.map(&:to_i).map{|v|v-1};end
def rr(n);n.times.map{r};end
def rrd(n);n.times.map{rd};end
def rrb(n);n.times{yield r};end
def rrbd(n);n.times{yield rd};end

gets;$/=' ';p$<.map(&:to_i).inject:gcd