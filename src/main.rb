require "pathname"
require "digest/md5"

basedir = Pathname.new("/home")

submits = [
  ["001/empty.txt", 1],
  ["001/hello.txt", 1],
  ["001/three.txt", 2],
  ["001/clone.txt", 1],
  ["001/hundred.txt", 2],
  ["001/middle.txt", 3],
  ["002/target.txt", 10],
  ["003/range.txt", 10],
  ["004/output.txt", 30],
  ["005/target.txt", 1],
  ["005/time.txt", 1],
]

Pathname.new("/home/").children.each do |path|
  next unless path.directory?
  submits.each do |name, point|
    file = path + name
    md5 = Digest::MD5.file(file).to_s
    pp [name, point, md5]
  end
end
