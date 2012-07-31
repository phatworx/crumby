# encoding: utf-8
module Crumby::Renderer
  # base for renderer
  # @abstract
  class Base
    attr_reader :view, :trail, :options

    def initialize(trail, view, options)
      @trail = trail
      @view = view
      @options = default_options.merge options
    end

    # render trail
    # @return [String] rendered trail
    def render
      render_list do
        trail.entries.each do |entry|
          render_entry(entry)
        end
      end
    end

    # empty default options
    # @abstract
    def default_options
      {}
    end

    # @abstract
    def render_list(&block)
      raise NotImplementedError
    end

    # @abstract
    def render_entry(entry)
      raise NotImplementedError
    end

  end
end
