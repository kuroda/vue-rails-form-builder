module VueRailsFormBuilder
  module FormHelper
    def vue_form_with(**options)
      unless respond_to?(:form_with)
        raise "Your Rails does not implement form_with helper."
      end

      options[:camelize] ||= false
      options[:builder] ||= VueRailsFormBuilder::FormBuilder
      if block_given?
        form_with(options, &Proc.new)
      else
        form_with(options)
      end
    end

    def vue_form_for(record, options = {}, &block)
      options[:camelize] ||= false
      options[:builder] ||= VueRailsFormBuilder::FormBuilder
      form_for(record, options, &block)
    end
  end
end
