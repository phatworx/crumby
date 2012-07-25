# encoding: utf-8
module Crumby

  module Helper
    extend ActiveSupport::Concern

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

    def crumby(*args)
      options = args.extract_options!
      renderer = options.delete(:renderer)
      scope = args.first || :default
      crumby_trail(scope).renderer(renderer).render(options)
    end

  end

end
