const std = @import("std");
const zbench = @import("zbench");
const test_allocator = std.testing.allocator;

fn sooSleepy() void {
    std.time.sleep(100_000_000);
}

fn sleepBenchmark(_: *zbench.Benchmark) void {
    _ = sooSleepy();
}

test "bench test sleepy" {
    const resultsAlloc = std.ArrayList(zbench.BenchmarkResult).init(test_allocator);
    var benchmarkResults = zbench.BenchmarkResults.init(resultsAlloc);
    defer benchmarkResults.deinit();
    var bench = try zbench.Benchmark.init("Sleep Benchmark", test_allocator, .{});

    try zbench.run(sleepBenchmark, &bench, &benchmarkResults);
    try benchmarkResults.prettyPrint();
}
