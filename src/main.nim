import sequtils,strutils,math,algorithm,tables
when true:
  let get = iterator:string {.closure.} = (for s in stdin.readAll.split: yield s)
  let read = proc:int = get().parseInt
  template rep(a,b):seq = newSeqWith(b,a)
  template `min=`(a,b) = (if a > b: a = b)
  template `max=`(a,b) = (if a < b: a = b)
  const inf = int.high div 2

when true:
  const Mod = 1000000007
  type fin = distinct int
  converter toFin(a:int):fin = fin((a mod Mod+Mod)mod Mod)
  converter toInt(a:fin):int = a.int
  proc`+`(a,b:fin):fin = a.int + b.int
  proc`-`(a,b:fin):fin = a.int - b.int
  proc`*`(a,b:fin):fin = a.int * b.int
  proc`+=`(a:var fin; b:fin) = a = a+b
  proc`-=`(a:var fin; b:fin) = a = a-b
  proc`*=`(a:var fin; b:fin) = a = a*b
  proc`/`(a,b:fin):fin = a * b ^ (Mod - 2)
  proc`/=`(a:var fin; b:fin) = a = a / b
  type FacTable = object
    fa, fi: seq[fin]
  proc initFacTable(n:Natural):FacTable =
    var fa, fi = 1.fin.repeat n+1
    for i in 2..n: fa[i] = fa[i-1] * i
    fi[n] = 1 / fa[n]
    for i in countdown(n,3): fi[i-1] = fi[i] * i
    FacTable(fa:fa, fi:fi)
  proc nCk(ft:FacTable; n,r:int):fin =
    if n<r or n<0 or r<0: 0
    else: ft.fa[n] * ft.fi[r] * ft.fi[n-r]
  proc popcount(bit: int): int = bit.toBin(64).count('1')
  proc paritySign(bit: int): int = (if bit.popcount mod 2 == 0: 1 else: -1)

# ################################################################################
# template main =
#   # a個からb個選び、残りa-b個からc個選ぶ
#   proc solve(ft:FacTable, a,b,c:int):fin =
#     ft.nCk(a,b) * ft.nCk(a-b,c)

#   let R,C,X,Y,D,L = read()
#   let ft = initFacTable(1000)

#   # 包除原理を利用
#   # 四方の壁の「いずれか」に隙間がある
#   # 全体 - 壁の一つに隙間がある4パターン + 4パターンが2つ重なった分 - 3つ重なった分 + 4つ重なった分
#   var ans = 0.fin
#   for bit in 0..<(1 shl 4):
#     var x = X - popcount(bit and 0b0011); x.max= 0
#     var y = Y - popcount(bit and 0b1100); y.max= 0
#     ans += ft.solve(x * y, D, L) * bit.paritySign

#   # 壁で囲んだ範囲が動く自由度
#   ans *= (R - X + 1) * (C - Y + 1)
#   echo ans

# main()
let ft = initFacTable(100000)
echo ft.nCk(100000,30000)