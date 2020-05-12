const path = require("path");
const chokidar = require("chokidar");
const exec = require("child_process").exec;

const watcher = chokidar.watch("src/", {
    persistent: true,
});

const log = console.log.bind(console);

const langExp = {
    ".rb": "ruby",
    ".cpp": "cpp",
    ".jl": "julia",
    ".cr": "crystal",
    ".py": "python3",
    ".pypy": "pypy3",
    ".hs": "haskell",
    ".clj": "clojure",
    ".nim": "nim",
};

const cmdStrings = {
    "ruby": "cat src/input.txt | ruby src/main.rb",
    "cpp": "g++ src/main.cpp && cat src/input.txt | ./a.out",
    "julia": "cat src/input.txt | julia src/main.jl",
    "crystal": "cat src/input.txt | crystal src/main.cr",
    "python3": "cat src/input.txt | python3 src/main.py",
    "pypy3": "cat src/input.txt | pypy3 src/main.pypy",
    "haskell": "cat src/input.txt | runghc src/main.hs",
    "clojure": "cat src/input.txt | clojure src/main.clj",
    "nim": "cat src/input.txt | nim c -r --stdout:off --hints:off --warning[UnusedImport]:off src/main.nim",
};

let lang = "ruby";

watcher.on("ready", () => {
    log("==================================================");
    log("Watching, ready for change.\n");
    watcher.on("change", (pathname, stats) => {
        const stime = Date.now();
        log(`change ${pathname} detected.\n`);
        
        const extName = path.extname(pathname);
        const langType = langExp[extName];
        if (langType) lang = langType;
        else if (extName != ".txt") return;
        log(`lang type is ${lang}\n`);

        const cmdString = cmdStrings[lang]
        exec(cmdString, { maxBuffer: 1024 * 1024 },  (err, stdout, stderr) => {
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