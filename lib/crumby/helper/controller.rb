# encoding: utf-8
module Crumby
  module Helper
    module ControllerHelper
      extend ActiveSupport::Concern

      included  do
        helper_method :crumby_title
        helper_method :crumby_trail
      end

      def crumby_trail(scope = :default)
        raise ArgumentError if scope.nil?
        scope = scope.to_sym

        @crumby_trails = {} if @crumby_trails.nil?
        @crumby_trails[scope] ||= Crumby::Trail.new
      end

      def add_crumby(*args)
        options = args.extract_options!
        scope = options.delete(:scope) || :default
        crumby_trail(scope).add(*args, options)
      end

      def crumby_title(*args)
        options = args.extract_options!
        scope = options.delete(:scope) || :default
        crumby_trail(scope).title(*args, options)
      end
    end
  end
end
