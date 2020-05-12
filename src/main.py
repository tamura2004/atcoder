from scipy import signal
n, *t = map(int, open(0).read().split())
a = signal.fftconvolve(t[::2], t[1::2])
print(0, *list(map(round, a)), sep="\n")
