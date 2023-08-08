const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    var i: usize = 0;
    while (i < 10) : (i += 1) {
      try stdout.print("Hello, {s}!\n", .{"world"});
    }
}