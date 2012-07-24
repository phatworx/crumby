module Crumby
  module Renderer
    class Base
      attr_reader :breadcrumbs

      def initialize(breadcrumbs)
        @breadcrumbs = breadcrumbs
      end

    end
  end
end
