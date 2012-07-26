# encoding: utf-8
module Crumby
  module Helper
    module ViewHelper
      def crumby(*args)
        options = args.extract_options!
        scope = args.first || :default
        crumby_trail(scope).render(self, options)
      end
    end
  end
end
