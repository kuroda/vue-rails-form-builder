version = File.read(File.expand_path("../VERSION",__FILE__)).strip

Gem::Specification.new do |s|
  s.name        = "vue-form-for"
  s.version     = version
  s.authors     = [ "Tsutomu KURODA" ]
  s.email       = "t-kuroda@oiax.jp"
  s.homepage    = "https://github.com/kuroda/vue-form-for"
  s.description = "This gem provides three view helpers for Rails app: " +
                  "vue_form_for, vue_tag, vue_content_tag."
  s.summary     = "A custom Rails form builder for Vue.js"
  s.license     = "MIT"

  s.required_ruby_version = ">= 2.2.2"
  s.add_dependency "actionview", ">= 4.2", "< 6"
  s.add_dependency "railties", ">= 4.2", "< 6"

  s.files = %w(CHANGELOG.md README.md MIT-LICENSE) + Dir.glob("lib/**/*")
end
