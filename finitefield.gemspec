Gem::Specification.new do |s|
  s.name = %q{finitefield}
  s.version = "0.1.0"
  s.date = %q{2008-12-22}
  s.authors = ["Stephen Doyle"]
  s.has_rdoc = true
  s.summary = %q{Finite Field implementation in Ruby.}
  s.homepage = %q{http://finitefield.rubyforge.org/}
  s.description = %q{Finite Field implementation in Ruby.}
  s.files = [ "README.txt", "LICENSE.txt", "lib/finitefield.rb", 
    "test/ts_finitefield.rb", "test/tc_basic.rb", "test/tc_gf2.rb"] +
    Dir['examples/**/*.rb']
  s.rdoc_options << '--title' << 'FiniteField Documentation'
  s.require_paths << 'lib'
  s.rubyforge_project = 'finitefield'
  s.test_file = "test/ts_finitefield.rb"
end