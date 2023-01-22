lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name = "trapdoor"
  s.version = "0.4.0"
  s.authors = ["OMAR"]
  s.summary = "Expose sensitive values to your environment without leaking them"
  s.description = "trapdoor"
  s.license = "MIT"
  s.homepage = "https://github.com/ancat/trapdoor"

  s.files = Dir["README.md", "lib/**/*.rb"]

  s.required_ruby_version = ">= 2.5"
end
