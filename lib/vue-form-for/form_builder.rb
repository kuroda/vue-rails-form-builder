module VueFormFor
  class FormBuilder < ActionView::Helpers::FormBuilder
    (field_helpers - [:label, :fields_for]).each do |selector|
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

    def submit(value = nil, options = {})
      resolve_vue_options(options)
      super(value, options)
    end

    def button(value = nil, options = {}, &block)
      resolve_vue_options(options)
      super(value, options, &block)
    end

    private def resolve_vue_options(options)
      if options[:v].kind_of?(Hash)
        h = options.delete(:v)
        h.each do |key, value|
          case key
          when /\A[:@]/
            options[key] = value
          else
            options[:"v-#{key}"] = value
          end
        end
      end

      if options[:bind].kind_of?(Hash)
        h = options.delete(:bind)
        h.each do |key, value|
          if value.kind_of?(String)
            options[:"v-bind:#{key}"] = value
          end
        end
      end

      if options[:on].kind_of?(Hash)
        h = options.delete(:on)
        h.each do |key, value|
          if value.kind_of?(String)
            options[:"v-on:#{key}"] = value
          end
        end
      end

      %i(checked disabled multiple readonly selected).each do |attr_name|
        if options[attr_name].kind_of?(String)
          options[:"v-bind:#{attr_name}"] = options.delete(attr_name)
        end
      end

      %i(text html show if else else_if for).each do |directive|
        if options[directive].kind_of?(String)
          options[:"v-#{directive}"] = options.delete(directive)
        end
      end

      %i(pre cloak once).each do |directive|
        if options[directive]
          options.delete(directive)
          options[:"v-#{directive}"] = "v-#{directive}"
        end
      end
    end
  end
end
