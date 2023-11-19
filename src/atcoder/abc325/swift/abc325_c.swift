protocol IGraph {
    func each_node(_ f: (Int, Int) -> Void)
    func each(_ y: Int, _ x: Int, _ f: (Int, Int) -> Void)
}

class Grid: IGraph {
    let h: Int
    let w: Int
    let s: [[Character]]
    var seen: [[Bool]]

    init(h: Int, w: Int, s: [[Character]]) {
        self.h = h
        self.w = w
        self.s = s
        self.seen = [[Bool]](
            repeating: [Bool](repeating: false, count: w),
            count: h
        )
    }

    func each_node(_ f: (Int, Int) -> Void) {
        for y in 0 ..< h {
            for x in 0 ..< w {
                if seen[y][x] || s[y][x] == "." {
                    continue
                }
                f(y, x)
            }
        }
    }

    func each(_ y: Int, _ x: Int, _ f: (Int, Int) -> Void) {
        seen[y][x] = true
        for dy in -1...1 {
            for dx in -1...1 {
                if abs(dy) + abs(dx) == 0 {
                    continue
                }
                let ny = y + dy
                let nx = x + dx
                if outside(ny, nx) {
                    continue
                }
                if seen[ny][nx] || s[ny][nx] == "." {
                    continue
                }
                seen[ny][nx] = true
                f(ny, nx)
            }
        } 
    }

    func outside(_ y: Int, _ x: Int) -> Bool {
        return !inside(y, x)
    }

    func inside(_ y: Int, _ x: Int) -> Bool {
        return 0 <= y && y < h && 0 <= x && x < w
    }
}

struct Solver {
    let grid: IGraph

    func solve() -> Int {
        var ans = 0
        grid.each_node { y, x in
            ans += 1
            dfs(y, x)
        }
        return ans
    }

    func dfs(_ y: Int, _ x: Int) {
        grid.each(y, x) { ny, nx in
            // print((y,x,ny,nx))
            dfs(ny, nx)
        }
    }
}

let line = readLine()!.split(separator: " ").map { Int($0)!  }
let (h, w) = (line[0], line[1])
let s = (1...h).map { _ in Array(readLine()!) }
let grid = Grid(h: h, w: w, s: s)
let solver = Solver(grid: grid)
print(solver.solve())
