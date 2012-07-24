# encoding: utf-8
module Crumby

  module Helper
    extend ActiveSupport::Concern

    def crumbs(scope = :default)
      raise ArgumentError if scope.nil?
      scope = scope.to_sym

      @crumbs = {} if @crumbs.nil?
      @crumbs[scope] ||= Crumby::Breadcrumbs.new
    end

    def add_crumb(*args)
      options = args.extract_options!
      scope = options.delete(:scope) || :default
      crumbs(scope).add(*args, options)
    end

    def crumby_title(scope = :default)
      crumbs(scope).title
    end

    def breadcrumbs(*args)
      options = args.extract_options!
      scope = args.first || :default
      crumbs(scope).render(options)
    end

  end

end
