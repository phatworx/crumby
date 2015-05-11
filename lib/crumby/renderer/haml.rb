# encoding: utf-8
module Crumby::Renderer
  # haml renderer
  class Haml < Base

    # @return [Hash] default options for this renderer
    def default_options
      {
        divider: "/",
        link_last: false,
        link_first: true
      }
    end

    # render list by block
    # the block call render_entry for each entry
    def render_list(&block)
      view.capture_haml do
        view.haml_tag :ul, class: "breadcrumb" do
          yield
        end
      end
    end

    # render entry
    # @param [Crumby::Entry] entry that will be rendered
    def render_entry(entry)
      view.haml_tag :li, class: (entry.last? ? 'active' : nil) do
        if entry.route.nil? or (entry.last? and not options[:link_last]) or (entry.first? and not options[:link_first])
          view.haml_tag :span, entry.label
        else
          view.haml_concat view.link_to(entry.label, entry.route)
        end
        view.haml_tag "span.divider", options[:divider] if not entry.last? and not options[:divider].is_a?(FalseClass)
      end
    end

  end
end
