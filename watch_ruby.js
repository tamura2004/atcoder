const chokidar = require("chokidar");
const exec = require("child_process").exec;

const watcher = chokidar.watch("src/", {
    persistent: true,
});

const log = console.log.bind(console);

watcher.on("ready", () => {
    log("==================================================");
    log("Watching, ready for change.\n");
    watcher.on("change", () => {
        const stime = Date.now();
        log("change detected.\n");
        exec("cat src/input.txt | ruby src/main.rb", { maxBuffer: 1024 * 1024 },  (err, stdout, stderr) => {
            if (err) {
                log(err);
            } else {
                log("==================================================");
                log(`${Date.now() - stime}ms`);
                // log("--------------------------------------------------");
                log("=== stdout ===");
                log(stdout);
                log("=== stderr ===");
                log(stderr);
            }
        });
    })
})