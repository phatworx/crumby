# encoding: utf-8
module Crumby::Helper
  # controller helper
  module ControllerHelper
    extend ActiveSupport::Concern

    included do
      helper_method :crumby_title
      helper_method :crumby_trail
    end

    # return crumby_trail by scope
    # @param [Symbol, String] scope
    def crumby_trail(scope = :default)
      raise ArgumentError if scope.nil?
      scope = scope.to_sym
      @crumby_trails = {} if @crumby_trails.nil?
      @crumby_trails[scope] ||= Crumby::Trail.new
    end

    # render trail
    # @see Crumby::Trail#render
    # @see Crumby::Renderer::Base
    # @overload crumby(options)
    #   @param [Hash] options passthrough to Trail#render
    # @overload crumby(scope, options)
    #   @param [Symbol, String] scope scope of trail
    #   @param [Hash] options passthrough to Trail#render
    def add_crumby(*args)
      options = args.extract_options!
      scope = options.delete(:scope) || :default
      crumby_trail(scope).add(*args, options)
    end


    # render trail
    # @see Crumby::Trail#title
    # @overload crumby(options)
    #   @param [Hash] options passthrough to Crumby::Trail#title
    #   @option options [String, Symbol] :scope extract scope from options before passthrough
    # @overload crumby(suffix, options)
    #   @param [String] suffix passthrough to Crumby::Trail#title
    #   @param [Hash] options passthrough to Crumby::Trail#title
    #   @option options [String, Symbol] :scope extract scope from options before passthrough
    def crumby_title(*args)
      options = args.extract_options!
      scope = options.delete(:scope) || :default
      crumby_trail(scope).title(*args, options)
    end
  end
end
