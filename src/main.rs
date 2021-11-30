use proconio::input;

fn main() {
  input! {
    n: usize,
    a: [i64; n],
    b: [i64; n],
  }

  let mut ans = 0;

  for i in 0..n {
    ans += a[i] * b[i];
  }

  if ans == 0 {
    println!("Yes");
  } else {
    println!("No");
  }
}