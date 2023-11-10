let n = Int(readLine()!)!
var cnt = [Int](repeating: 0, count: 24)

for _ in 0..<n {
    let line = readLine()!.split(separator: " ").map { Int($0)! }
    let (w, x) = (line[0], line[1])

    for j in 9..<18 {
        let t = (j + x) % 24
        cnt[t] += w
    }   
}

print(cnt.max()!)