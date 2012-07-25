module Crumby
  module Renderer
    class Base
      attr_reader :trail

      def initialize(trail)
        @trail = trail
      end

      def render(*args)
        options = default_options.merge args.extract_options!
        render_list(options) do
          trail.entries.each do |entry|
            render_entry(entry, options)
          end
        end
      end

      def default_options
        {}
      end

      def render_list(options, &block)
        raise NotImplementedError
      end

      def render_entry(entry, options)
        raise NotImplementedError
      end

    end
  end
end
