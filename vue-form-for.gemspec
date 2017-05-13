version = File.read(File.expand_path("../VERSION",__FILE__)).strip

Gem::Specification.new do |s|
  s.name        = "vue-form-for"
  s.version     = version
  s.authors     = [ "Tsutomu KURODA" ]
  s.email       = "t-kuroda@oiax.jp"
  s.homepage    = "https://github.com/kuroda/vue-form-for"
  s.description = "This gem has been deprecated and has been replaced by 'vue-rails-form-builder'." +
                  "See: https://rubygems.org/gems/vue-rails-form-builder"
  s.summary     = "A custom Rails form builder for Vue.js"
  s.license     = "MIT"

  s.required_ruby_version = ">= 2.2.2"
  s.add_dependency "actionview", ">= 4.2", "< 6"
  s.add_dependency "railties", ">= 4.2", "< 6"

  s.files = %w(CHANGELOG.md README.md MIT-LICENSE) + Dir.glob("lib/**/*")

  s.post_install_message = <<-MESSAGE
  !    The 'vue-form-for' gem has been deprecated and has been replaced by 'vue-rails-form-builder'.
  !    See: https://rubygems.org/gems/vue-rails-form-builder
  !    And: https://github.com/kuroda/vue-rails-form-builder
  MESSAGE
end
