require_relative "./vue_options_resolver"

module VueFormFor
  class FormBuilder < ActionView::Helpers::FormBuilder
    include VueFormFor::VueOptionsResolver

    (field_helpers - [:label, :check_box, :radio_button, :fields_for])
      .each do |selector|
      class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
        def #{selector}(method, options = {})
          resolve_vue_options(options)
          options[:"v-model"] ||= "\#{@object_name}.\#{method}"
          super(method, options)
        end
      RUBY_EVAL
    end

    def label(method, text = nil, options = {}, &block)
      resolve_vue_options(options)
      super(method, text, options, &block)
    end

    def check_box(method, options = {}, checked_value = "1", unchecked_value = "0")
      resolve_vue_options(options)
      super(method, options, checked_value, unchecked_value)
    end

    def radio_button(method, tag_value, options = {})
      resolve_vue_options(options)
      super(method, tag_value, options)
    end

    def submit(value = nil, options = {})
      resolve_vue_options(options)
      super(value, options)
    end

    def button(value = nil, options = {}, &block)
      resolve_vue_options(options)
      super(value, options, &block)
    end
  end
end
