require "listen"
require "open3"
require "time"
require "colorize"

$last_exec_time = Time.new - 10

LANG_EXT = {
  ".dart" => "dart",
  ".dot" => "dot",
  ".rb" => "ruby",
  ".cpp" => "cpp",
  ".jl" => "julia",
  ".cr" => "crystal",
  ".py" => "python3",
  ".pl" => "perl",
  ".pypy" => "pypy3",
  ".hs" => "haskell",
  ".clj" => "clojure",
  ".nim" => "nim",
  ".java" => "java",
  ".scala" => "scala",
  ".kt" => "kotlin",
  ".cs" => "csharp",
  ".scm" => "gauche",
  ".go" => "go",
  ".rs" => "rust",
  ".maxima" => "maxima",
  ".lisp" => "common_lisp",
  ".zig" => "zig",
}

# %s はソースコードの絶対パスに置き換え
COMPILE = {
  "cpp" => "g++ %s -std=c++17",
  # "ruby" => "cat %s | clip.exe && touch flag.txt",
  "ruby" => "cat %s | clip.exe",
  # "crystal" => "ruby build.rb %s target.cr",
  "crystal" => "ruby build.rb %s target.cr && cat target.cr | grep -v pp! |  clip.exe",
  "java" => "javac -d dist src/Main.java",
  "scala" => "scalac -d dist %s",
  "kotlin" => "kotlinc src/main.kt -include-runtime -d dist/kotlin.jar",
  "csharp" => "mcs src/main.cs -out:dist/csharp.exe",
  "go" => "go build -buildmode=exe -o ./dist/go.out %s",
  "rust" => "cargo build",
# "common_lisp" => 'sbcl --noinform -eval "(compile-file \"src/main.cl\")" --quit',
}

# %s はソースコードの絶対パスに置き換え
EXECUTE = {
  "dart" => "dart %s",
  "dot" => "cat %s | graph-easy --from=dot --as_ascii",
  "ruby" => "ruby %s",
  "cpp" => "./a.out",
  "julia" => "julia src/main.jl",
  # "crystal" => "dist/crystal.out",
  # "crystal" => "crystal run --release target.cr",
  "crystal" => "crystal run target.cr",
  # "crystal" => "crystal run target.cr && cat target.cr | grep -v pp! | clip.exe",
  "python3" => "python3 src/main.py",
  "perl" => "perl src/main.pl",
  "pypy3" => "pypy3 src/main.pypy",
  "haskell" => "runghc src/main.hs",
  "clojure" => "clojure src/main.clj",
  # "nim" => "nim c -r --hints:off src/main.nim",
  "nim" => "nim c -r --stdout:off --hints:off --warning[UnusedImport]:off src/main.nim",
  "java" => "java -classpath dist Main",
  "scala" => "scala -classpath dist Main",
  "kotlin" => "kotlin dist/kotlin.jar",
  "csharp" => "echo mono dist/csharp.exe",
  "gauche" => "gosh src/main.scm",
  "go" => "./dist/go.out",
  "rust" => "target/debug/main",
  "maxima" => "maxima -b src/main.maxima",
  "common_lisp" => "sbcl --script %s",
  "zig" => "docker run -i --rm -v \"$PWD:/app\" euantorano/zig run /app/src/main.zig",
}

class Task
  attr_accessor :lang, :src, :input, :path
  attr_accessor :exec_str, :compile_str

  def initialize
    @lang = "crystal"
    @src = "src/main.cr"
    @input = "src/input.txt"
    @path = nil
    @exec_str = nil
  end

  def parse_params(params)
    return unless params[0]
    @path = Pathname(params[0])
    puts "=" * 50
    puts "#{path.basename} was changed.\n"
  end

  def check_lang_and_src
    if path && path.extname != ".txt"
      @lang = LANG_EXT[path.extname.to_s]
      @src = path.to_s
    end
    info "lang type is #{lang}."
    info "src is #{src}."
  end

  def check_compile
    if cmd = COMPILE[lang]
      cmd = COMPILE[lang] % src
      info "Compled by #{cmd}"
      `#{cmd}`
    end
  end

  def check_exec
    @exec_str = EXECUTE[lang] % src
    info "Task Execute by #{exec_str}."
  end

  def error(msg)
    STDERR.puts msg.colorize(:red)
  end

  def success(msg)
    STDERR.puts msg.colorize(:green)
  end

  def info(msg)
    STDERR.puts msg.colorize(:blue)
  end

  def warning(msg)
    STDERR.puts msg.colorize(:yellow)
  end

  def exec_src(exec_str, input, stime)
    o, e, s = Open3.capture3(exec_str, stdin_data: input)
    puts "=" * 50
    puts "=== stdout ==="
    puts o
    puts
    puts "=== stderr ==="
    puts e
    puts
    puts "=== time ==="
    printf("%.2fms", (Time.now - stime) * 1000)
    puts
  end

  def run
    puts "=" * 50
    puts "watching, ready for change\n\n"

    src_listener = Listen.to("src") do |params|
      if Time.now - $last_exec_time < 3.0
        # error "skip"
        next
      end
      $last_exec_time = Time.now

      parse_params(params)
      check_lang_and_src
      check_compile
      check_exec
      input = open("src/input.txt")
      stime = Time.now
      exec_src(exec_str, input, stime)
    end

    lib_listener = Listen.to("lib") do |params|
      if Time.now - $last_exec_time < 3.0
        # error "skip"
        next
      end
      $last_exec_time = Time.now

      parse_params(params)
      next if path.extname != ".cr" && path.extname != ".rb"

      src = path.relative_path_from(Pathname.pwd).to_s

      case src
      when /lib\/crystal\/spec/
        src = Pathname src
      when /lib\/ruby\/test/
        src = Pathname src
      when /lib\/crystal/
        if src =~ /spec/
          src = Pathname src
        else
          src = Pathname(src.to_s.gsub(".cr", "_spec.cr"))
        end
      else
        src = Pathname(src.to_s.gsub("lib/ruby", "lib/ruby/test/test_").gsub(".cr", "_spec.cr"))
      end

      if !src.exist?
        error "No spec exists, #{src}."
        next
      end

      cmd = path.extname == ".cr" ? "crystal spec --error-trace #{src}" : "ruby #{src}"
      o, e, s = Open3.capture3(cmd)
      if o =~ /0 failures, 0 errors/
        success o
      else
        error o
      end
      warning e
    end

    src_listener.start
    lib_listener.start
    sleep
  end
end

Task.new.run
