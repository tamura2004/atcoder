def garner( mlist, alist ):
  m, x = mlist[0], alist[0]
  i = 1
  while i<len(mlist):
    x = x + m * inverse( m, mlist[i] ) * ( alist[i] - x )
    m *= mlist[i]
    i += 1
  return x % m, m

if __name__ == '__main__':
  print( garner( [ 3, 5, 7 ], [ 2, 3, 3 ] ) )