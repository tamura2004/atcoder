import sequtils,strutils,math,algorithm,tables
when true:
  let get = iterator: string {.closure.} = (for s in stdin.readAll.split: yield s)
  let read = proc: int = get().parseInt
  template rep(a,b): seq = newSeqWith(b,a)
  template `min=`(a,b) = (if a > b: a = b)
  template `max=`(a,b) = (if a < b: a = b)
  const inf = 1 shl 30
  template say(ans) = echo ["No","Yes"][1-int(ans)]

template main =
  let
    n,m = read()
    a = read().rep(n)
    b = a.sum
    ans = a.filterIt(it * 4 * m >= b).len >= m

  say(ans)
  
main()
