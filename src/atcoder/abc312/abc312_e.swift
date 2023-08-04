let n = Int(readLine()!)!
var dp = [[[Int?]]](
  repeating: [[Int?]](
    repeating: [Int?](
      repeating: 0,
      count: 3
    ),
    count: 3
  ),
  count: 3
)