require 'vue-form-for/form_helper'
require 'vue-form-for/tag_helper'

module VueFormFor
  class Railtie < Rails::Railtie
    initializer "vue-form-for.view_form_helper" do
      ActiveSupport.on_load :action_view do
        include VueFormFor::FormHelper
        include VueFormFor::TagHelper
      end
    end
  end
end
