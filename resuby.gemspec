$LOAD_PATH.push(File.expand_path('../lib', __FILE__))
require 'resuby/version'

Gem::Specification.new do |s|
  s.name             = 'resuby'
  s.version          = Resuby::VERSION
  s.date             = '2018-09-10'
  s.summary          = 'Resume generator'
  s.description      =
    'Resuby generates an HTML and CSS resume that you can access with your
    browser. You simply define the content of your resume in a YAML file, and
    resuby will take care of creating a resume that you can use.'
  s.authors          = ['Mario Lopez']
  s.email            = 'lopezrobles.mario@gmail.com'
  s.files            = `git ls-files lib/`.split("\n")
  s.executables      = `git ls-files bin/`.split("\n").map{ |f| File.basename(f) }
  s.extra_rdoc_files = ['README.md']
  s.homepage         = 'https://github.com/mardotio/resuby'
  s.license          = 'MIT'

  s.add_dependency('sass', ['>= 3.5.0', '< 4.0.0'])
  s.add_dependency('optimist', ['>= 3.0.0', '< 4.0.0'])
end
