module VueRailsFormBuilder
  module FormHelper
    def vue_form_for(record, options = {}, &block)
      options[:builder] ||= VueRailsFormBuilder::FormBuilder
      form_for(record, options, &block)
    end
  end
end
