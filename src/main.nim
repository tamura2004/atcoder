import sequtils,strutils,tables
let get = iterator:string {.closure.} = (for s in stdin.readAll.split: yield s)
let read = proc:int = get().parseInt
template rep(a,b):seq = newSeqWith(b,a)

type Station = ref object
  table: CountTable[int]
  num: int

proc newStation(): Station =
  result = new Station
  result.num = 0
  result.table = initCountTable[int]()

proc add(s: Station, a: int) =
  if s.table.hasKey(2540 - a): s.num += s.table[2540 - a]
  s.table.inc(a)

let n,m = read()
var g = newStation().rep(n);

for i in 0..<m:
  var a,b,c = read()
  a.dec
  b.dec
  g[a].add(c)
  g[b].add(c)

var ans = 0
for i in 0..<n:
  ans += g[i].num

echo ans