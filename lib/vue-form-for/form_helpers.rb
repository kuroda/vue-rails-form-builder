module VueFormFor
  module FormHelpers
    def vue_form_for(record, options = {}, &block)
      options[:builder] ||= VueFormFor::FormBuilder
      form_for(record, options, &block)
    end
  end
end
