require "vue-rails-form-builder/form_helper"
require "vue-rails-form-builder/tag_helper"

module VueRailsFormBuilder
  class Railtie < Rails::Railtie
    initializer "vue-rails-form-builder.view_form_helper" do
      ActiveSupport.on_load :action_view do
        include VueRailsFormBuilder::FormHelper
        include VueRailsFormBuilder::TagHelper
      end
    end
  end
end
