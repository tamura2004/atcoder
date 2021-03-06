require "listen"
require "open3"
require "time"
require "colorize"

LANG_EXT = {
  ".rb" => "ruby",
  ".cpp" => "cpp",
  ".jl" => "julia",
  ".cr" => "crystal",
  ".py" => "python3",
  ".pypy" => "pypy3",
  ".hs" => "haskell",
  ".clj" => "clojure",
  ".nim" => "nim",
  ".java" => "java",
  ".kt" => "kotlin",
  ".cs" => "csharp",
}

COMPILE = {
  "cpp" => "g++ src/main.cpp -std=c++14 -I /home/tamura/src/acl",
  # "crystal" => "crystal build --release --no-debug -o dist/crystal.out src/main.cr",
  "java" => "javac -d dist src/Main.java",
  "kotlin" => "kotlinc src/main.kt -include-runtime -d dist/kotlin.jar -XXLanguage:+InlineClasses",
  "csharp" => "mcs src/main.cs -out:dist/csharp.exe",
}

EXECUTE = {
  "ruby" => "ruby %s",
  "cpp" => "./a.out",
  "julia" => "julia src/main.jl",
  # "crystal" => "dist/crystal.out",
  # "crystal" => "crystal run --release %s",
  "crystal" => "crystal run %s",
  "python3" => "python3 src/main.py",
  "pypy3" => "pypy3 src/main.pypy",
  "haskell" => "runghc src/main.hs",
  "clojure" => "clojure src/main.clj",
  # "nim" => "nim c -r --hints:off src/main.nim",
  "nim" => "nim c -r --stdout:off --hints:off --warning[UnusedImport]:off src/main.nim",
  "java" => "java -classpath dist Main",
  "kotlin" => "kotlin dist/kotlin.jar",
  "csharp" => "mono dist/csharp.exe",
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
      info `#{cmd}`
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
      parse_params(params)
      check_lang_and_src
      check_compile
      check_exec
      input = open("src/input.txt")
      stime = Time.now
      exec_src(exec_str, input, stime)
    end

    lib_listener = Listen.to("lib") do |params|
      parse_params(params)
      next if path.extname != ".cr"

      if path.basename.to_s =~ /spec/
        src = path.relative_path_from(Pathname.pwd)
      else
        src = Pathname("lib/crystal/spec/#{path.basename(".cr")}_spec.cr")
      end

      if !src.exist?
        error "No spec exists, #{src}."
        next
      end

      cmd = "crystal spec #{src}"
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
