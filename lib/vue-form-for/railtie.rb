require 'vue-form-for/form_helpers'

module VueFormFor
  class Railtie < Rails::Railtie
    initializer "vue-form-for.view_form_helpers" do
      ActiveSupport.on_load :action_view do
        include VueFormFor::FormHelpers
      end
    end
  end
end
