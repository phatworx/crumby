# encoding: utf-8
module Crumby
  module Renderer
    class Base
      attr_reader :view, :trail, :options

      def initialize(trail, view, options)
        @trail = trail
        @view = view
        @options = default_options.merge options
      end

      def render(*args)
        render_list do
          trail.entries.each do |entry|
            render_entry(entry)
          end
        end
      end

      def default_options
        {}
      end

      def render_list(&block)
        raise NotImplementedError
      end

      def render_entry(entry)
        raise NotImplementedError
      end

    end
  end
end
