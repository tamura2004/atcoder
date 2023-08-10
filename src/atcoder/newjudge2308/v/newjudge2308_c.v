import os
import datatypes { Set }

fn main() {
	n := os.input("").int()
	mut bag := Set[int]{}
	for ball in 1 .. n * 2 + 2 {
		bag.add(ball)
	}

	for {
		my_ball := bag.pop()!
		println(my_ball)

		your_ball := os.input("").int()
		if your_ball == 0 { exit(0) }
		bag.remove(your_ball)
	}
}