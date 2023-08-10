import lemoncmd.proconio { input }
import math.vec { Vec2 }
import arrays { max }

struct Queue {
  n int
  mut:
  lo int
  hi int
  buffer []int
}

fn new_queue(n int) Queue {
  buffer := [0].repeat(n)
  return Queue {
    n: n,
    lo: 0,
    hi: -1,
    buffer: buffer,
  }
}

fn (mut q Queue) push(v int) {
  q.hi += 1
  q.hi %= q.n
  q.buffer[q.hi] = v
}

fn (mut q Queue) pop() int {
  ans := q.buffer[q.lo]
  q.lo += 1
  q.lo %= q.n
  return ans
}

fn (q Queue) len() int {
  return q.hi - q.lo + 1
}

struct Graph {
	n int
mut:
	g [][]int
}

fn new_graph(n int) Graph {
  mut g := Graph { n: n }
  for i := 0; i < n; i++ {
    g.g << []int{}
  }
  return g
}

fn (mut g Graph) add(v int, nv int) {
  g.g[v - 1] << (nv - 1)
  g.g[nv - 1] << (v - 1)
}

fn (g Graph) depth(root int) []int {
  mut ans := [-1].repeat(g.n)
  mut q := new_queue(1000000)

  ans[root] = 0
  q.push(root)

  for q.len() > 0 {
    v := q.pop()
    for nv in g.g[v] {
      if ans[nv] != -1 {
        continue
      }
      ans[nv] = ans[v] + 1
      q.push(nv)
    }
  }

  return ans
}

struct Input {
  n1 int
  n2 int
  m int
  edges []Vec2[int] [m]
}

dd := input[Input]()
n := dd.n1 + dd.n2
mut g := new_graph(n)

for v in dd.edges {
  g.add(v.x, v.y)
}

depth1 := g.depth(0)
depth2 := g.depth(n - 1)
ans := max(depth1)! + max(depth2)! + 1
println(ans)
