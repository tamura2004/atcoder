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
  ".java": "java",
  ".kt": "kotlin",
  ".cs": "csharp",
};

const compileStrings = {
  "cpp": "g++ src/main.cpp",
  "crystal": "crystal build --release --no-debug -o dist/crystal.out src/main.cr",
  "java": "javac -d dist src/Main.java",
  "kotlin": "kotlinc src/main.kt -include-runtime -d dist/kotlin.jar -XXLanguage:+InlineClasses",
  "csharp": "mcs src/main.cs -out:dist/csharp.exe",
};

const executeStrings = {
  "ruby": "cat src/input.txt | ruby src/main.rb",
  "cpp": "cat src/input.txt | ./a.out",
  "julia": "cat src/input.txt | julia src/main.jl",
  "crystal": "cat src/input.txt | dist/crystal.out",
  "python3": "cat src/input.txt | python3 src/main.py",
  "pypy3": "cat src/input.txt | pypy3 src/main.pypy",
  "haskell": "cat src/input.txt | runghc src/main.hs",
  "clojure": "cat src/input.txt | clojure src/main.clj",
  // "nim": "cat src/input.txt | nim c -r --hints:off src/main.nim",
  "nim": "cat src/input.txt | nim c -r --stdout:off --hints:off --warning[UnusedImport]:off src/main.nim",
  "java": "cat src/input.txt | java -classpath dist Main",
  "kotlin": "cat src/input.txt | kotlin dist/kotlin.jar",
  "csharp": "cat src/input.txt | mono dist/csharp.exe",
};

let lang = "ruby";

watcher.on("ready", () => {
  log("==================================================");
  log("Watching, ready for change.\n");
  watcher.on("change", (pathname, stats) => {
    log(`change ${pathname} detected.\n`);

    const extName = path.extname(pathname);
    const langType = langExp[extName];
    if (langType) lang = langType;
    else if (extName != ".txt") return;
    log(`lang type is ${lang}\n`);

    const compileString = compileStrings[lang] || "echo nop";
    const executeString = executeStrings[lang]
    exec(compileString, { maxBuffer: 1024 * 1024 }, (err, stdout, stderr) => {
      if (err) log(err);
      const stime = Date.now();
      exec(executeString, { maxBuffer: 1024 * 1024 }, (err, stdout, stderr) => {
        if (err) {
          log(err);
        } else {
          log("==================================================");
          log("=== stdout ===");
          log(stdout);
          log("=== stderr ===");
          log(stderr);
          log("=== time ===");
          log(`${Date.now() - stime}ms`);
        }
      });
    });
  })
})