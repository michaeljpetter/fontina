require_relative 'lib/fontina/version'

Gem::Specification.new do |gem|
  gem.name          = 'fontina'
  gem.version       = Fontina::VERSION
  gem.author        = 'Michael Petter'
  gem.email         = 'michaeljpetter@gmail.com'

  gem.summary       = 'A cheesy font utility'
  gem.description   = <<-END
    Fetches, parses, and describes font files.
  END
  gem.homepage      = 'http://github.com/michaeljpetter/fontina'
  gem.license       = 'MIT'

  gem.platform      = Gem::Platform::RUBY
  gem.files         = Dir.glob %w(lib/**/* Gemfile *.gemspec LICENSE* README*)
  gem.require_paths = ['lib']

  gem.add_dependency 'bindata', '>=2.3.5'
  gem.add_dependency 'faraday'
  gem.add_dependency 'faraday_middleware'
  gem.add_dependency 'mores', '>=0.1.5'

  gem.add_development_dependency 'bundler', '~> 1.7'
  gem.add_development_dependency 'rake', '~> 10.0'
  gem.add_development_dependency 'rspec', '~> 3.4'
  gem.add_development_dependency 'rspec-its', '~> 1.2'
end
