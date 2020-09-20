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
  "crystal" => "DEBUG=1 crystal run %s",
  # "crystal" => "crystal spec src/main_spec.cr",
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

lang = "ruby"
src = "src/main.rb"

listener = Listen.to("src") do |params|
  path = Pathname.new(params[0])
  puts "change #{path.basename} detected.\n\n"

  if path.extname != ".txt"
    lang = LANG_EXT[path.extname.to_s]
    src = path.to_s
  end
  puts "lang type is #{lang}.\n\n"
  puts "src is #{src}.\n\n"

  if compile_str = COMPILE[lang]
    puts `#{compile_str}`
  end

  exec_str = EXECUTE[lang] % src
  puts "exec str is #{exec_str}"
  input = open("src/input.txt")
  stime = Time.now

  Open3.popen3(exec_str) do |i,o,e,w|
    i.write(input.read)
    i.close
    puts "=" * 50
    puts "=== stdout ==="
    o.each do |line|
      puts line
    end
    puts
    puts "=== stderr ==="
    e.each do |line|
      puts line
    end
    puts
    puts "=== time ==="
    printf("%.2fms", (Time.now - stime) * 1000)
    puts
  end
  # puts `DEBUG=1 crystal run #{params[0]}`
end

lib_listener = Listen.to("lib") do |params|
  path = Pathname(params[0])
  puts "change #{path.basename} detected.\n\n"
  
  return if path.extname != ".cr"

  if path.basename.to_s =~ /spec/
    src = path.relative_path_from(Pathname.pwd)
  else
    src = Pathname("lib/crystal/spec/#{path.basename(".cr")}_spec.cr")
  end
  
  puts "crystal spec #{src}"
  Open3.popen3("crystal spec #{src}") do |i,o,e,w|
    i.close
    msg = o.read
    if msg =~ /0 failures, 0 errors/
      puts msg.green
    else
      puts msg.red
    end
  end
end

puts "=" * 50
puts "watching, ready for change\n\n"
listener.start
lib_listener.start
sleep