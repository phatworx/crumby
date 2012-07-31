# encoding: utf-8
module Crumby::Helper
  # view helper
  module ViewHelper
    # render breadcrumb
    # @see Crumby::Trail#render
    # @see Crumby::Renderer::Base
    # @overload crumby(options)
    #   @param [Hash] options
    #   @param [Hash] options passthrough to renderer
    # @overload crumby(scope, options)
    #   @param [Symbol, String] scope scope of breadcrumb
    #   @param [Hash] options passthrough to renderer
    def crumby(*args)
      options = args.extract_options!
      scope = args.first || :default
      crumby_trail(scope).render(self, options)
    end
  end
end
