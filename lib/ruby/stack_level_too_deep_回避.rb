if !ENV['RUBY_THREAD_VM_STACK_SIZE']
  #Rubyパスを取得するには、rbconfigかrubygemsを使う。AtCoderでは--disable-gemsされているので、require 'rubygems'は必須である。
  #require 'rbconfig';RUBY=File.join(RbConfig::CONFIG['bindir'],RbConfig::CONFIG['ruby_install_name'])
  require 'rubygems';RUBY=Gem.ruby
  exec({'RUBY_THREAD_VM_STACK_SIZE'=>'100000000'},RUBY,$0) #100MB
end