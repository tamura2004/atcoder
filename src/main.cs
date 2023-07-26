using System;

enum Motion {
  Up,
  Down,
  Left,
  Right,
  Stop
}

class Program {
  static void Main (string[] args) {
    var input = Console.ReadLine().Split(' ');
    var h = int.Parse(input[0]);
    var w = int.Parse(input[1]);
    var g = from _ in 

    for (var i = 0; i < q; i++) {
      input = Console.ReadLine().Split(' ');
      var ty = int.Parse(input[0]);
      var v = int.Parse(input[1]);
      var nv = int.Parse(input[2]);

      if (ty == 0) {
        uf.unite(v, nv);
      } else {
        if (uf.same(v, nv)) {
          Console.WriteLine("Yes");
        } else {
          Console.WriteLine("No");
        }
      }
    }
  }
}