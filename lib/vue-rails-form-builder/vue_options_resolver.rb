module VueRailsFormBuilder
  module VueOptionsResolver
    private def resolve_vue_options(options)
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

      %i(text html show if else else_if for model).each do |directive|
        if options[directive].kind_of?(String)
          options[:"v-#{directive.to_s.dasherize}"] = options.delete(directive)
        end
      end

      %i(pre cloak once).each do |directive|
        if options[directive]
          options.delete(directive)
          options[:"v-#{directive}"] = "v-#{directive}"
        end
      end
    end

    private def add_v_model_attribute(method, options)
      namespace = @object_name.gsub(/\[/, ".").gsub(/\]/, "")
      options[:"v-model"] ||= "#{namespace}.#{method}"
    end
  end
end
