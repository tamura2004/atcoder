require "pathname"

class Indent
  def initialize
    @level = 0
  end

  def inc
    @level += 1
  end

  def dec
    @level -= 1
  end

  def spc
    "  " * @level
  end
end

def camelcase(s)
  s.split(/_/).map(&:capitalize).join
end

def snakecase(s)
  s.split(/(?=[A-Z])/).map(&:downcase).join("_")
end

ind = Indent.new

lib = Pathname.pwd + "lib/crystal"
ARGV.each do |name|
  src = lib + (name + ".cr")
  spec = lib + "spec" + (name + "_spec.cr")
  modules = name.split("/").map { |s| camelcase(s) }
  classname = modules.pop

  if src.exist? || spec.exist?
    raise "File #{src} or #{spec} already exists."
  end

  # ディレクトリが無ければ作る
  src.dirname.mkpath
  spec.dirname.mkpath

  # クラスファイルを作る
  src.open("w") do |fh|
    modules.each do |module_name|
      fh.puts ind.spc + "module #{module_name}"
      ind.inc
    end

    fh.puts ind.spc + "class #{classname}"
    fh.puts ind.spc + "end"

    modules.each do |module_name|
      ind.dec
      fh.puts ind.spc + "end"
    end
  end

  # specファイルを作る
  spec.open("w") do |fh|
    fh.puts "require \"spec\""

    cname = snakecase(classname)
    mname = modules.map { |s| snakecase(s) }.join("/")

    fh.puts "require \"crystal/#{mname}/#{cname}.cr\""

    qname = (modules + [classname]).join("::")

    fh.puts "include #{qname}"
    fh.puts

    fh.puts "describe #{qname} do"
    fh.puts " it \"usage\" do"
    fh.puts " end"
    fh.puts "end"
  end
end
