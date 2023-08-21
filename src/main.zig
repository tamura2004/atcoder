const std = @import("std");

pub fn main() !void {
    const reader = std.io.getStdIn().reader();
    std.debug.print("hello, {d}!\n", .{ reader.getByte() });
}
