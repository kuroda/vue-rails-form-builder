module VueFormFor
  class FormBuilder < ActionView::Helpers::FormBuilder
    (field_helpers - [:label, :fields_for]).each do |selector|
      class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
        def #{selector}(method, options = {})
          options[:"v-model"] ||= "\#{@object_name}.\#{method}"
          super(method, options)
        end
      RUBY_EVAL
    end
  end
end
