module Crumby
  module Renderer
    class Haml < Base

      def default_options
        {
          divider: "/",
          link_last: false,
          link_first: true
        }
      end

      def render_list(options, &block)
        capture_haml do
          haml_tag :ul, class: "breadcrumb" do
            yield
          end
        end
      end

      def render_entry(entry, options)
        haml_tag :li, class: (entry.last? ? 'active' : nil) do
          if entry.route.nil? or (entry.last? and not options[:link_last]) or (entry.first? and not options[:link_first])
            haml_concat entry.label
          else
            haml_concat link_to(entry.label, entry.route)
          end
          haml_tag "span.divider", options[:divider] unless entry.last?
        end
      end

    end
  end
end
