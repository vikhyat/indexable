Gem::Specification.new do |s|
  s.name = 'indexable'
  s.version = '0.0.4'
  s.date = '2013-12-10'

  s.homepage = 'https://github.com/vikhyat/indexable'
  s.summary = 'Rack middleware that executes javascript before serving pages to crawlers.'
  s.authors = ["Vikhyat Korrapati"]
  s.email = 'c@vikhyat.net'
  s.license = 'MIT'

  s.files = ['lib/indexable.rb', 'lib/render_page.js', 'lib/phantomjs.rb']

  s.add_dependency 'rack'
end
