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
        exec("cat src/input.txt | ruby src/main.rb", (err, stdout, stderr) => {
            if (err) {
                log(err);
            } else {
                log("==================================================");
                log((new Date()).toLocaleString());
                log("--------------------------------------------------\n");
                log("=== stdout ===");
                log(stdout);
                log("=== stderr ===");
                log(stderr);
            }
        });
    })
})