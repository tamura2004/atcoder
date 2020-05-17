import sequtils,strutils,math,algorithm,tables
when true:
  let get = iterator:string {.closure.} = (for s in stdin.readAll.split: yield s)
  let read = proc:int = get().parseInt
  template rep(a,b):seq = newSeqWith(b,a)
  template `min=`(a,b) = (if a > b: a = b)
  template `max=`(a,b) = (if a < b: a = b)
  const inf = int.high div 2

type work = object
  id,head,tail:int

proc newWorks(s:string,c:int):seq[work] =
  for i,v in s:
    if v == 'o':
      result.add work(id:i+1, head:i+1, tail:i+1+c)

proc cmpWork(a,b:work):int =
  case cmp(a.tail, b.tail)
  of 1: 1
  of -1: -1
  else: cmp(a.head, b.head)

proc takeWorks(a:var seq[work],n:int):seq[work] =
  a.sort(cmpWork)
  var pre = work(tail: -inf)
  for now in a:
    if pre.tail < now.head:
      result.add now
      pre = now
    if result.len >= n: break
  result.sort(proc(a,b:work):int = cmp(a.id,b.id))

proc revWork(w:work):work =
  result.id = w.id
  result.head = inf - w.tail
  result.tail = inf - w.head

let n,m,c = read()
let s = get()

var a = newWorks(s,c)
var left = takeWorks(a,m)

var b = a.map(revWork)
var right = takeWorks(b,m)

var ans = false
for i, a in left:
  let b = right[i]
  if a.id == b.id:
    echo a.head


