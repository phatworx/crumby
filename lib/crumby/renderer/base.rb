module Crumby
  module Renderer
    class Base
      attr_reader :breadcrumbs

      def initialize(breadcrumbs)
        @breadcrumbs = breadcrumbs
      end

      def render(*args)
        options = args.extract_options!
      end

    end
  end
end
