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

pub fn main() !void {
    const a = getu();
    const bc = getvecu();
    const s = gets();
    const b = bc[0];
    const c = bc[1];

    try stdout.writer().print("{d} {s}\n", .{ a + b + c, s });
}
