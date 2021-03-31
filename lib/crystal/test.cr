tests = <<-EOS
1 2
----
3
====
4 5
----
7
====
6 7
----
13
EOS

tests.split(/=+/).each do |test|
  input, want = test.split(/-+/)
  pp! [input, want]
end


