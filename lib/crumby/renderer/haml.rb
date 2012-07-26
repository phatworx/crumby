# encoding: utf-8
module Crumby
  module Renderer
    class Haml < Base
      include ::Haml::Helpers

      def default_options
        {
          divider: "/",
          link_last: false,
          link_first: true
        }
      end

      def render_list(&block)
        view.capture_haml do
          view.haml_tag :ul, class: "breadcrumb" do
            yield
          end
        end
      end

      def render_entry(entry)
        view.haml_tag :li, class: (entry.last? ? 'active' : nil) do
          if entry.route.nil? or (entry.last? and not options[:link_last]) or (entry.first? and not options[:link_first])
            view.haml_concat entry.label
          else
            view.haml_concat view.link_to(entry.label, entry.route)
          end
          view.haml_tag "span.divider", options[:divider] unless entry.last?
        end
      end

    end
  end
end
