require_relative "./vue_options_resolver"

module VueRailsFormBuilder
  module TagHelper
    include VueRailsFormBuilder::VueOptionsResolver

    def vue_tag(name, options = nil, open = false, escape = true)
      resolve_vue_options(options) if options
      tag(name, options, open, escape)
    end

    def vue_content_tag(name, content_or_options_with_block = nil, options = nil,
      escape = true, &block)

      if block_given?
        if content_or_options_with_block.is_a?(Hash)
          resolve_vue_options(content_or_options_with_block)
        end
      else
        resolve_vue_options(options) if options
      end

      content_tag(name, content_or_options_with_block, options, escape, &block)
    end
  end
end
