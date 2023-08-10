const std = @import("std");

const stdout = std.io.getStdOut();
var buffer: [1000000]u8 = undefined;

const stdin = std.io.getStdIn();
var buf = std.io.bufferedReader(stdin.reader());
var stdin_reader = buf.reader();

var allocator: std.mem.Allocator = undefined;

fn gets() []const u8 {
    const line = stdin_reader.readUntilDelimiterOrEof(&buffer, '\n') catch unreachable;
    return allocator.dupe(u8, line.?) catch unreachable;
}

fn geti() i64 {
    return std.fmt.parseInt(i64, gets(), 10) catch unreachable;
}

fn getu() u64 {
    return std.fmt.parseInt(u64, gets(), 10) catch unreachable;
}

fn getvecu() []const u64 {
    var vecu = std.ArrayList(u64).init(allocator);
    var it = std.mem.split(u8, gets(), " ");
    var v = it.next();
    while (v != null) : (v = it.next()) {
        const val = std.fmt.parseInt(u64, v.?, 10) catch unreachable;
        vecu.append(val) catch unreachable;
    }
    return vecu.items;
}

fn pow10(n: usize) u64 {
  var x: u64 = 1;
  var i: usize = 0;
  while (i < n) : (i += 1) {
    x *= 10;
  }
  return x;
}

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    allocator = arena.allocator();

    const xk = getvecu();
    var x = xk[0];
    var k = xk[1];
    var i: usize = 0;
    while (i < k) : (i += 1) {
      const y = pow10(i + 1);
      const r = x % y;
      const q = r / pow10(i);
      if (5 <= q) {
        x += y;
      }
      x -= r;
    }
    try stdout.writer().print("{d}\n", .{x});
}