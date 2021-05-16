import "dart:io";
import "dart:math";

void main() {
  var ab = stdin.readLineSync().split(" ").map((x)=>int.parse(x)).toList();
  // var x = int.parse(stdin.readLineSync());
  // var s = stdin.readLineSync();

  var n = ab[0];
  var a = ab[1];
  var b = ab[2];

  var ans = n - a + b;
  print(ans);
}
