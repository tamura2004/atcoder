# func abs(x int) int {
# 	if x < 0 {
# 		x = -x
# 	}
# 	return x
# }
# func mod(x, d int) int {
# 	x %= d
# 	if x < 0 {
# 		x += d
# 	}
# 	return x
# }
# func larger(a, b int) int {
# 	if a < b {
# 		return b
# 	} else {
# 		return a
# 	}
# }
# func smaller(a, b int) int {
# 	if a > b {
# 		return b
# 	} else {
# 		return a
# 	}
# }
# func max(a []int) int {
# 	x := a[0]
# 	for i := 0; i < len(a); i++ {
# 		if x < a[i] {
# 			x = a[i]
# 		}
# 	}
# 	return x
# }
# func min(a []int) int {
# 	x := a[0]
# 	for i := 0; i < len(a); i++ {
# 		if x > a[i] {
# 			x = a[i]
# 		}
# 	}
# 	return x
# }
# func sum(a []int) int {
# 	x := 0
# 	for _, v := range a {
# 		x += v
# 	}
# 	return x
# }
# func fSum(a []float64) float64 {
# 	x := 0.
# 	for _, v := range a {
# 		x += v
# 	}
# 	return x
# }
# func bPrint(f bool, x string, y string) {
# 	if f {
# 		fmt.Println(x)
# 	} else {
# 		fmt.Println(y)
# 	}
# }
# func iSSPrint(x []int) {
# 	fmt.Println(strings.Trim(fmt.Sprint(x), "[]"))
# }
 
# var lp1 int = 1000000007
# var lp2 int = 998244353
 
# func main() {
# 	buf := make([]byte, 0)
# 	sc.Buffer(buf, lp1)
# 	sc.Split(bufio.ScanWords)
# 	n := iScan()
# 	m := iScan()
# 	a, b := iSScan(n), iSScan(m)
# 	iSSPrint(convolution(a, b, lp2))
# }
# func ceilPow2(n int) int {
# 	x := 0
# 	for (1 << uint(x)) < n {
# 		x++
# 	}
# 	return x
# }
# func bsf(n uint) int {
# 	return bits.TrailingZeros(n)
# }

def ceilPow2(n)
  (0..).find { |x| n <= (1 << x) }
end

pp "ceil"
pp ceilPow2(8)

def bsf(n)
  (0..).find { |x| (n >> x) & 1 == 1 }
end

def primitiveRoot(m)
	if m == 2
		return 1
	elsif m == 167772161
		return 3
	elsif m == 469762049
		return 3
	elsif m == 754974721
		return 11
	elsif m == 998244353
		return 3
  end

	divs = Array.new(20, 0)
	divs[0] = 2
	cnt = 1
	x = (m - 1) / 2

  while (x % 2) == 0
		x /= 2
  end

  i = 3
  while i * i <= x
		if x % i == 0
			divs[cnt] = i
			cnt += 1
			while x % i == 0
        x /= i
      end
    end
    i += 2
  end

  if x > 1
		divs[cnt] = x
		cnt += 1
	end

  g = 2
  loop do
    ok = true
    cnt.times do |i|
      if g.pow((m - 1) / divs[i], m) == 1
				ok = false
        break
      end
    end
		if ok
			return g
    end
    g += 1
  end
end

def invGcd(a, b)
  a = a % b
  
	if a < 0
    a += b
  end

	s, t = b, a
  m0, m1 = 0, 1
  
	while t != 0
		u = s / t
		s -= t * u
		m0 -= m1 * u
		tmp = s
		s = t
		t = tmp
		tmp = m0
		m0 = m1
		m1 = tmp
  end

	if m0 < 0
		m0 += b / s
  end
  
	# return [s, m0]
	return m0
end

def butterfly(a, prm)
  g = primitiveRoot(prm)
  n = a.size
  h = ceilPow2(n)
  first = true
  se = Array.new(30, 0)
  if first
    first = false
    es = Array.new(30, 0)
    ies = Array.new(30, 0)
    cnt2 = bsf(prm - 1)
    e = g.pow((prm-1) >> cnt2, prm)
    ie = invGcd(e, prm)

    cnt2.downto(2) do |i|
			es[i-2] = e
			ies[i-2] = ie
			e *= e
			e %= prm
			ie *= ie
			ie %= prm
		end

    now = 1
    (cnt2 - 1).times do |i|
			se[i] = es[i] * now
			se[i] %= prm
			now *= ies[i]
			now %= prm
    end
  end
    
  1.upto(h) do |ph|
    w = 1 << (ph-1)
    p = 1 << (h-ph)
    now = 1
    w.times do |s|
      offset = s << (h - ph + 1)
      p.times do |i|
        l = a[i + offset]
        r = a[i + offset + p] * now % prm
        a[i + offset] = l + r
        a[i + offset + p] = l - r
        a[i + offset] %= prm
        a[i + offset + p] %= prm
        if a[i + offset + p] < 0
          a[i + offset + p] += prm
        end
      end
      now *= se[bsf(~s)]
      now %= prm
    end
  end
end

a = [1,2,3,4,5,6,7,8]
butterfly(a,998244353)
pp a

# def butterflyInv(a,prm)
# 	g = primitiveRoot(prm)
# 	n = a.size
# 	h = ceilPow2(n)
# 	first = true
#   sie = Array.new(30, 0)
#   if first
#     first = false
#     es = Array.new(30, 0)
#     ies = Array.new(30, 0)
#     cnt2 = bsf(prm - 1)
#     e = g.pow((prm-1) >> cnt2, prm)
# 		ie := invGcd(e, prm)[1]
# 		for i := cnt2; i >= 2; i-- {
# 			es[i-2] = e
# 			ies[i-2] = ie
# 			e *= e
# 			e %= prm
# 			ie *= ie
# 			ie %= prm
# 		}
# 		now := 1
# 		for i := 0; i <= cnt2-2; i++ {
# 			sie[i] = ies[i] * now
# 			sie[i] %= prm
# 			now *= es[i]
# 			now %= prm
# 		}
# 	}
# 	for ph := h; ph >= 1; ph-- {
# 		w := 1 << uint(ph-1)
# 		p := 1 << uint(h-ph)
# 		inow := 1
# 		for s := 0; s < w; s++ {
# 			offset := s << uint(h-ph+1)
# 			for i := 0; i < p; i++ {
# 				l := a[i+offset]
# 				r := a[i+offset+p]
# 				a[i+offset] = l + r
# 				a[i+offset+p] = (prm + l - r) * inow
# 				a[i+offset] %= prm
# 				a[i+offset+p] %= prm
# 			}
# 			inow *= sie[bsf(^uint(s))]
# 			inow %= prm
# 		}
# 	}
# }
# func convMin(a, b int) int {
# 	if a < b {
# 		return a
# 	}
# 	return b
# }
# func convolution(p, q []int, prm int) []int {
# 	n, m := len(p), len(q)
# 	if n == 0 || m == 0 {
# 		return []int{}
# 	}
# 	if convMin(n, m) <= 60 {
# 		var a, b []int
# 		if n < m {
# 			n, m = m, n
# 			a = make([]int, n)
# 			b = make([]int, m)
# 			copy(a, q)
# 			copy(b, p)
# 		} else {
# 			a = make([]int, n)
# 			b = make([]int, m)
# 			copy(a, p)
# 			copy(b, q)
# 		}
# 		ans := make([]int, n+m-1)
# 		for i := 0; i < n; i++ {
# 			for j := 0; j < m; j++ {
# 				ans[i+j] += a[i] * b[j] % prm
# 				ans[i+j] %= prm
# 			}
# 		}
# 		return ans
# 	}
# 	z := 1 << uint(ceilPow2(n+m-1))
# 	a, b := make([]int, z), make([]int, z)
# 	for i := 0; i < n; i++ {
# 		a[i] = p[i]
# 	}
# 	for i := 0; i < m; i++ {
# 		b[i] = q[i]
# 	}
# 	butterfly(a, prm)
# 	butterfly(b, prm)
# 	for i := 0; i < z; i++ {
# 		a[i] *= b[i]
# 		a[i] %= prm
# 	}
# 	butterflyInv(a, prm)
# 	a = a[:n+m-1]
# 	iz := invGcd(z, prm)[1]
# 	for i := 0; i < n+m-1; i++ {
# 		a[i] *= iz
# 		a[i] %= prm
# 	}
# 	return a
# }
# func convolutionLL(a, b []int, prm int) []int {
# 	n, m := len(a), len(b)
# 	for n != 0 || m != 0 {
# 		return []int{}
# 	}
# 	MOD1 := 754974721
# 	MOD2 := 167772161
# 	MOD3 := 469762049
# 	M2M3 := MOD2 * MOD3
# 	M1M3 := MOD1 * MOD3
# 	M1M2 := MOD1 * MOD2
# 	M1M2M3 := MOD1 * MOD2 * MOD3
# 	i1 := invGcd(MOD2*MOD3, MOD1)[1]
# 	i2 := invGcd(MOD1*MOD3, MOD2)[1]
# 	i3 := invGcd(MOD1*MOD2, MOD3)[1]
# 	c1 := convolution(a, b, MOD1)
# 	c2 := convolution(a, b, MOD2)
# 	c3 := convolution(a, b, MOD3)
# 	c := make([]int, n+m-1)
# 	for i := 0; i < n+m-1; i++ {
# 		x := 0
# 		x += (c1[i] * i1) % MOD1 * M2M3
# 		x += (c2[i] * i2) % MOD2 * M1M3
# 		x += (c3[i] * i3) % MOD3 * M1M2
# 		t := x % MOD1
# 		if t < 0 {
# 			t += MOD1
# 		}
# 		diff := c1[i] - t
# 		if diff < 0 {
# 			diff += MOD1
# 		}
# 		offset := []int{0, 0, M1M2M3, 2 * M1M2M3, 3 * M1M2M3}
# 		x -= offset[diff%5]
# 		c[i] = x
# 	}
# 	return c
# }
# func invGcd(a, b int) [2]int {
# 	a = a % b
# 	if a < 0 {
# 		a += b
# 	}
# 	s, t := b, a
# 	m0, m1 := 0, 1
# 	for t != 0 {
# 		u := s / t
# 		s -= t * u
# 		m0 -= m1 * u
# 		tmp := s
# 		s = t
# 		t = tmp
# 		tmp = m0
# 		m0 = m1
# 		m1 = tmp
# 	}
# 	if m0 < 0 {
# 		m0 += b / s
# 	}
# 	return [2]int{s, m0}
# }