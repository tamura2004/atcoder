require "listen"
require "open3"
require "time"
require "colorize"

LANG_EXT = {
  ".dart" => "dart",
  ".dot" => "dot",
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
  ".scm" => "gauche",
  ".go" => "go",
}

COMPILE = {
  "cpp" => "g++ src/main.cpp -std=c++14 -I /home/tamura/src/acl",
  # "ruby" => "cat %s | clip.exe && touch flag.txt",
  "ruby" => "cat %s | clip.exe",
  "crystal" => "ruby build.rb %s target.cr && cat target.cr | grep -v pp! |  clip.exe",
  "java" => "javac -d dist src/Main.java",
  "kotlin" => "kotlinc src/main.kt -include-runtime -d dist/kotlin.jar",
  "csharp" => "mcs src/main.cs -out:dist/csharp.exe",
  "go" => "go build -buildmode=exe -o ./dist/go.out ./src/main.go",
}

EXECUTE = {
  "dart" => "dart %s",
  "dot" => "cat %s | graph-easy --from=dot --as_ascii",
  "ruby" => "ruby %s",
  "cpp" => "./a.out",
  "julia" => "julia src/main.jl",
  # "crystal" => "dist/crystal.out",
  # "crystal" => "crystal run --release target.cr",
  "crystal" => "crystal run target.cr",
  "python3" => "python3 src/main.py",
  "pypy3" => "pypy3 src/main.pypy",
  "haskell" => "runghc src/main.hs",
  "clojure" => "clojure src/main.clj",
  # "nim" => "nim c -r --hints:off src/main.nim",
  "nim" => "nim c -r --stdout:off --hints:off --warning[UnusedImport]:off src/main.nim",
  "java" => "java -classpath dist Main",
  "kotlin" => "kotlin dist/kotlin.jar",
  "csharp" => "mono dist/csharp.exe",
  "gauche" => "gosh src/main.scm",
  "go" => "./dist/go.out",
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
      next if path.extname != ".cr" && path.extname != ".rb"

      src = path.relative_path_from(Pathname.pwd).to_s

      case src
      when /lib\/crystal\/spec/
        src = Pathname src
      when /lib\/ruby\/test/
        src = Pathname src
      when /lib\/crystal/
        src = Pathname(src.to_s.gsub("lib/crystal", "lib/crystal/spec").gsub(".cr", "_spec.cr"))
      else
        src = Pathname(src.to_s.gsub("lib/ruby", "lib/ruby/test/test_").gsub(".cr", "_spec.cr"))
      end

      if !src.exist?
        error "No spec exists, #{src}."
        next
      end

      cmd = path.extname == ".cr" ? "crystal spec #{src}" : "ruby #{src}"
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
