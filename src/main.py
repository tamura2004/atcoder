import numpy as np

a = np.ones(100000)
b = np.ones(100000)
c = np.ones(100000)

d = np.convolve(a,np.convolve(b,c))

print(d)
