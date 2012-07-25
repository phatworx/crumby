module Crumby
  module Renderer
    class Base
      attr_reader :trail

      def initialize(trail)
        @trail = trail
      end

      def render(*args)
        options = args.extract_options!
      end

    end
  end
end
