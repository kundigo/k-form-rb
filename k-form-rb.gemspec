

Gem::Specification.new do |s|
  s.name        = "k-form-rb"
  s.version     = "0.1.4"
  s.authors     = [ "Dorian LUPU" ]
  s.email       = "dorian@kundigo.pro"
  s.homepage    = "https://github.com/kundigo/k-form-rb"
  s.description = "This gem provides view helpers & form builders for Rails apps." +
                  "It should be used in pair with k-form-js private npm package. "
  s.summary     = "A custom Rails form builder using custom tags"
  s.license     = "Private code that belongs to KUNDIGO SASU, FRANCE"

  s.required_ruby_version = ">= 2.2.2"
  s.add_dependency "actionview", ">= 5.2"
  s.add_dependency "railties", ">= 5.2"

  s.files = %w(CHANGELOG.md README.md) + Dir.glob("lib/**/*")
end
