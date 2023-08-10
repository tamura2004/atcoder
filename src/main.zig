const std = @import("std");
const stdin = std.io.getStdIn().reader();
const stdout = std.io.getStdOut().writer();
var buf: [100]u8 = undefined;

pub fn main() !void {
    const line = try stdin.readUntilDelimiterOrEof(buf[0..], '\n');
    const a = try std.fmt.parseInt(i64, line, 10);
    try stdout.print("hello, world.{d}\n", .{a});
}


// try stdout.print("A number please: ", .{});
