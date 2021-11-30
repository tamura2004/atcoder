using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using static System.IO.File;
using static System.IO.Directory;
using static System.IO.SearchOption;

class Program {
  static void Main (string[] args) {
    var opt = parse (args);

    var dir = opt.ContainsKey ("d") ? opt["d"] : GetCurrentDirectory ();

    var files = GetFiles (dir, "*", AllDirectories);
    var count = 0;
    foreach (var file in files) {
      var line_number = 0;
      foreach (var line in ReadLines (file)) {
        line_number++;
        count++;
        if (count % 10000 == 0) {
          int par = (int) ((count / 10000) % 50);
          Console.Error.Write (string.Format ("[{0}{1}]{2}\r",
            new string ('#', par),
            new string ('-', 50 - par),
            file
          ));
        }
        if (Regex.IsMatch (line, @"[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}")) {
          Console.WriteLine ($"{file},{line_number},{line}");
          break;
        }
      }
    }
  }

  static Dictionary<String, String> parse (string[] args) {
    var ans = new Dictionary<string, string> ();
    var isValue = false;
    var key = "";
    foreach (var arg in args) {
      if (isValue) {
        isValue = false;
        ans[key] = arg;
      } else {
        isValue = true;
        key = arg.Substring (1);
      }
    }
    return ans;
  }
}