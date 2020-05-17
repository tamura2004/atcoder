import sequtils,strutils,math,algorithm,tables
when true:
  let get = iterator: string {.closure.} = (for s in stdin.readAll.split: yield s)
  let read = proc: int = get().parseInt
  template rep(a,b): seq = newSeqWith(b,a)
  template `min=`(a,b) = (if a > b: a = b)
  template `max=`(a,b) = (if a < b: a = b)
  type P = (int,int)
  const inf = int.high div 2

proc main:int =
  let a = read().rep(3).sorted
  return a[^1] - a[0]

echo main()