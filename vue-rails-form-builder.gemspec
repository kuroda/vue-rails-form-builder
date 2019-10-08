version = File.read(File.expand_path("../VERSION",__FILE__)).strip

Gem::Specification.new do |s|
  s.name        = "vue-rails-form-builder"
  s.version     = version
  s.authors     = [ "Tsutomu KURODA" ]
  s.email       = "t-kuroda@oiax.jp"
  s.homepage    = "https://github.com/kuroda/vue-rails-form-builder"
  s.description = "This gem provides four view helpers for Rails app: " +
                  "vue_form_with, vue_form_for, vue_tag and vue_content_tag."
  s.summary     = "A custom Rails form builder for Vue.js"
  s.license     = "MIT"

  s.required_ruby_version = ">= 2.2.2"
  s.add_dependency "actionview", ">= 4.2", "< 7"
  s.add_dependency "railties", ">= 4.2", "< 7"

  s.files = %w(CHANGELOG.md README.md MIT-LICENSE) + Dir.glob("lib/**/*")
end
