when true:
  const Mod = 1000000007
  type fin* = distinct int
  converter toFin*(a:int):fin = fin((a mod Mod+Mod)mod Mod)
  converter toInt*(a:fin):int = a.int
  func`+`*(a,b:fin):fin = a.int + b.int
  func`-`*(a,b:fin):fin = a.int - b.int
  func`*`*(a,b:fin):fin = a.int * b.int
  proc`+=`*(a:var fin; b:fin) = a = a+b
  proc`-=`*(a:var fin; b:fin) = a = a-b
  proc`*=`*(a:var fin; b:fin) = a = a*b
  func`/`*(a,b:fin):fin = a * b ^ (Mod - 2)
  proc`/=`*(a:var fin; b:fin) = a = a / b
  type FacTable = object
    fa, fi: seq[fin]
  func initFacTable(n:Natural):FacTable =
    var fa, fi = 1.fin.repeat n+1
    for i in 2..n: fa[i] = fa[i-1] * i
    fi[n] = 1 / fa[n]
    for i in countdown(n,3): fi[i-1] = fi[i] * i
    FacTable(fa:fa, fi:fi)
  func binom(ft:FacTable; n,r:int):fin =
    if n<r or n<0 or r<0: 0
    else: ft.fa[n] * ft.fi[r] * ft.fi[n-r]