const gulp = require("gulp");
const exec = require("child_process").exec;
const watcher = gulp.watch(["main.rb", "input.txt"]);

watcher.on("change", () => {
    exec("cat input.txt | ruby main.rb", (err, stdout, stderr) => {
        if (err) {
            console.log(err);
        } else {
            console.log(stdout);
        }
    });
});

// gulp.task("run", (done) => {
//     exec("cat input.txt | ruby main.rb", (err, stdout, stderr) => {
//         if (err) {
//             console.log(err);
//         } else {
//             console.log(stdout);
//         }
//     });
//     done();
// });

// gulp.task("default", () => {
// });