lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name = "smuggle-env"
  s.version = "0.3.0"
  s.authors = ["OMAR"]
  s.summary = "Expose sensitive values to your environment without leaking them"
  s.description = "smuggle-env"
  s.license = "MIT"
  s.homepage = "https://github.com/ancat/smuggle-env"

  s.files = Dir["README.md", "lib/**/*.rb"]

  s.required_ruby_version = ">= 2.5"
end
