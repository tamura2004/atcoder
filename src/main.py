# FFT
# code from: https://atcoder.jp/contests/practice2/submissions/24974537
# but changed a little
_fft_mod = 998244353
_fft_imag = 911660635
_fft_iimag = 86583718
_fft_rate2 = (911660635, 509520358, 369330050, 332049552, 983190778, 123842337, 238493703, 975955924, 603855026, 856644456, 131300601, 842657263, 730768835, 942482514, 806263778, 151565301, 510815449, 503497456, 743006876, 741047443, 56250497, 867605899)
_fft_irate2 = (86583718, 372528824, 373294451, 645684063, 112220581, 692852209, 155456985, 797128860, 90816748, 860285882, 927414960, 354738543, 109331171, 293255632, 535113200, 308540755, 121186627, 608385704, 438932459, 359477183, 824071951, 103369235)
_fft_rate3 = (372528824, 337190230, 454590761, 816400692, 578227951, 180142363, 83780245, 6597683, 70046822, 623238099,  183021267, 402682409, 631680428, 344509872, 689220186, 365017329, 774342554, 729444058, 102986190, 128751033, 395565204)
_fft_irate3 = (509520358, 929031873, 170256584, 839780419, 282974284, 395914482, 444904435, 72135471, 638914820, 66769500, 771127074, 985925487, 262319669, 262341272, 625870173, 768022760, 859816005, 914661783, 430819711, 272774365, 530924681)

def _butterfly(a):
	n = len(a)
	h = (n - 1).bit_length()
	len_ = 0
	while len_ < h:
		if h - len_ == 1:
			p = 1 << (h - len_ - 1)
			rot = 1
			for s in range(1 << len_):
				offset = s << (h - len_)
				for i in range(p):
					l = a[i + offset]
					r = a[i + offset + p] * rot % _fft_mod
					a[i + offset] = (l + r) % _fft_mod
					a[i + offset + p] = (l - r) % _fft_mod
				if s + 1 != (1 << len_):
					rot *= _fft_rate2[(~s & -~s).bit_length() - 1]
					rot %= _fft_mod
			len_ += 1
		else:
			p = 1 << (h - len_ - 2)
			rot = 1
			for s in range(1 << len_):
				rot2 = rot * rot % _fft_mod
				rot3 = rot2 * rot % _fft_mod
				offset = s << (h - len_)
				for i in range(p):
					a0 = a[i + offset]
					a1 = a[i + offset + p] * rot
					a2 = a[i + offset + p * 2] * rot2
					a3 = a[i + offset + p * 3] * rot3
					a1na3imag = (a1 - a3) % _fft_mod * _fft_imag
					a[i + offset] = (a0 + a2 + a1 + a3) % _fft_mod
					a[i + offset + p] = (a0 + a2 - a1 - a3) % _fft_mod
					a[i + offset + p * 2] = (a0 - a2 + a1na3imag) % _fft_mod
					a[i + offset + p * 3] = (a0 - a2 - a1na3imag) % _fft_mod
				if s + 1 != (1 << len_):
					rot *= _fft_rate3[(~s & -~s).bit_length() - 1]
					rot %= _fft_mod
			len_ += 2
 
def _butterfly_inv(a):
	n = len(a)
	h = (n - 1).bit_length()
	len_ = h
	while len_:
		if len_ == 1:
			p = 1 << (h - len_)
			irot = 1
			for s in range(1 << (len_ - 1)):
				offset = s << (h - len_ + 1)
				for i in range(p):
					l = a[i + offset]
					r = a[i + offset + p]
					a[i + offset] = (l + r) % _fft_mod
					a[i + offset + p] = (l - r) * irot % _fft_mod
				if s + 1 != (1 << (len_ - 1)):
					irot *= _fft_irate2[(~s & -~s).bit_length() - 1]
					irot %= _fft_mod
			len_ -= 1
		else:
			p = 1 << (h - len_)
			irot = 1
			for s in range(1 << (len_ - 2)):
				irot2 = irot * irot % _fft_mod
				irot3 = irot2 * irot % _fft_mod
				offset = s << (h - len_ + 2)
				for i in range(p):
					a0 = a[i + offset]
					a1 = a[i + offset + p]
					a2 = a[i + offset + p * 2]
					a3 = a[i + offset + p * 3]
					a2na3iimag = (a2 - a3) * _fft_iimag % _fft_mod
					a[i + offset] = (a0 + a1 + a2 + a3) % _fft_mod
					a[i + offset + p] = (a0 - a1 +
										 a2na3iimag) * irot % _fft_mod
					a[i + offset + p * 2] = (a0 + a1 -
											 a2 - a3) * irot2 % _fft_mod
					a[i + offset + p * 3] = (a0 - a1 -
											 a2na3iimag) * irot3 % _fft_mod
				if s + 1 != (1 << (len_ - 1)):
					irot *= _fft_irate3[(~s & -~s).bit_length() - 1]
					irot %= _fft_mod
			len_ -= 2
 
def _convolution_naive(a, b):
	n = len(a)
	m = len(b)
	ans = [0] * (n + m - 1)
	if n < m:
		for j in range(m):
			for i in range(n):
				ans[i + j] = (ans[i + j] + a[i] * b[j]) % _fft_mod
	else:
		for i in range(n):
			for j in range(m):
				ans[i + j] = (ans[i + j] + a[i] * b[j]) % _fft_mod
	return ans
 
def _convolution_fft(a, b):
	a = a.copy()
	b = b.copy()
	n = len(a)
	m = len(b)
	z = 1 << (n + m - 2).bit_length()
	a += [0] * (z - n)
	_butterfly(a)
	b += [0] * (z - m)
	_butterfly(b)
	for i in range(z):
		a[i] = a[i] * b[i] % _fft_mod
	_butterfly_inv(a)
	a = a[:n + m - 1]
	iz = pow(z, _fft_mod - 2, _fft_mod)
	for i in range(n + m - 1):
		a[i] = a[i] * iz % _fft_mod
	return a
 
 
def _convolution_square(a):
	a = a.copy()
	n = len(a)
	z = 1 << (2 * n - 2).bit_length()
	a += [0] * (z - n)
	_butterfly(a)
	for i in range(z):
		a[i] = a[i] * a[i] % _fft_mod
	_butterfly_inv(a)
	a = a[:2 * n - 1]
	iz = pow(z, _fft_mod - 2, _fft_mod)
	for i in range(2 * n - 1):
		a[i] = a[i] * iz % _fft_mod
	return a
 
 
def convolution(a, b):
	n = len(a)
	m = len(b)
	if n == 0 or m == 0:
		return []
	if min(n, m) <= 0:
		return _convolution_naive(a, b)
	if a is b:
		return _convolution_square(a)
	return _convolution_fft(a, b)
# ----

mod = 998244353
N = 7 * 10**5 + 5
fact = [1]*(N+1)
factinv = [1]*(N+1)

for i in range(2, N+1):
	fact[i] = fact[i-1] * i % mod

factinv[-1] = pow(fact[-1], mod-2, mod)
for i in range(N-1, 1, -1):
	factinv[i] = factinv[i+1] * (i+1) % mod

def cmb(a, b):
	if (a < b) or (b < 0):
		return 0
	return fact[a] * factinv[b] % mod * factinv[a-b] % mod


 
class RelaxedMultiplication():
    # h = f * g
    def __init__(self):
        self.f = []
        self.g = []
        self.h = []
        self.n = 0
    
    def calc(self, l1, r1, l2, r2):
        self.h += [0] * (r1 + r2 - 1 - len(self.h))
        for i, a in enumerate(convolution(self.f[l1:r1], self.g[l2:r2]), l1 + l2):
            self.h[i] = (self.h[i] + a) % mod
        
    def append(self, a, b):
        self.f.append(a)
        self.g.append(b)
        self.n += 1
        n = self.n
        m = (n + 1) & -(n + 1)
        s = 0
        if m <= n:
            a = 1
            while a <= m:
                self.calc(n - a, n, s, s + a)
                self.calc(s, s + a, n - a, n)
                s += a
                a <<= 1
        else:
            a = 1
            while a < m >> 1:
                self.calc(n - a, n, s, s + a)
                self.calc(s, s + a, n - a, n)
                s += a
                a <<= 1
            self.calc(n - a, n, s, s + a)
        return self.h[n-1]

def fast(a, b, c, t):
	# a <= b <= c へ
	d = [a, b, c]
	d.sort()
	a, b, c = d[0], d[1], d[2]

	p = (b-a) // 2
	q = (c-a) // 2

	r = [0] * (t+2)
	s = [0] * (t+2)
	v = [0] * (t+2)
	for i in range(t+2):
		r[i] = factinv[i] * factinv[i+p] % mod * factinv[i+q] % mod
		s[i] = factinv[i] * factinv[i+q-p] % mod * factinv[i+q] % mod
		v[i] = factinv[i] * factinv[i] % mod * factinv[i] % mod	

	f = convolution(r, s)
	w = convolution(v, v)
	for i in range(len(f)):
		f[i] *= fact[i+q] * fact[i+q] % mod * fact[i+q] % mod
		f[i] %= mod
		w[i] *= fact[i] * fact[i] % mod * fact[i] % mod
		w[i] %= mod

	#print(f)

	arr = RelaxedMultiplication()

	rui = [0] * (t + 1)
	aaa = 0
	for j in range(q, t+1):
		aaa = f[j-q]
		aaa -= arr.append(rui[j-1], w[j-q+1])
		aaa %= mod
		rui[j] = aaa
	
	return rui[t] * pow(8, mod-1-t, mod) % mod

a,b,c,t = map(int,input().split())
print(fast(a, b, c, t))
