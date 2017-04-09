require 'vue-form-for/form_helper'

module VueFormFor
  class Railtie < Rails::Railtie
    initializer "vue-form-for.view_form_helper" do
      ActiveSupport.on_load :action_view do
        include VueFormFor::FormHelper
      end
    end
  end
end
