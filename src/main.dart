import 'dart:io';

void main() {
	List a = stdin.readLineSync()?.split(" ").map((x) => int.parse(x)).toList();
	print("$a[1]");
}

