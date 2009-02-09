FOUNDRY_GEMSPEC = Gem::Specification.new do |s|
  s.name     = "foundry"
  s.version  = "1.0.0"
  s.date     = "2009-02-09"
  s.summary  = s.description = "Another fixture replacement using named_scope. It's fast and simple."
  s.email    = "jeremymcanally@gmail.com"
  s.homepage = "http://github.com/jeremymcanally/foundry/"
  s.has_rdoc = true
  s.authors  = ["Jeremy McNally"]
  s.files    = ["init.rb",
                "lib/dsl.rb",
                "lib/foundry.rb",
                "MIT-LICENSE",
                "Rakefile",
                "README.rdoc",
                "test/dsl_test.rb",
                "test/foundry_test.rb",
                "test/test_helper.rb"]
  s.rdoc_options = ["--main", "README.rdoc"]
  s.extra_rdoc_files = ["README.rdoc"]
end
