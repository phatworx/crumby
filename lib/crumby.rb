require 'active_support/lazy_load_hooks'
require 'active_support/core_ext/module/attribute_accessors'

module Crumby
  autoload :Entry, 'crumby/entry'
  autoload :Trail, 'crumby/trail'
  autoload :Helper, 'crumby/helper'
  autoload :Renderer, 'crumby/renderer'

  # default renderer
  mattr_accessor :renderer
  @@renderer = Renderer::Haml

  class << self

    # configure crumby
    #   Crumby.configure do
    #     # default renderer
    #     # renderer = Renderer::Haml
    #   end
    def configure(&block)
      self.instance_eval &block
    end

    def init!
      ActiveSupport.on_load(:action_controller) do
        ActionController::Base.send :include, Crumby::Helper::ControllerHelper
      end

      ActiveSupport.on_load(:action_view) do
        ActionView::Base.send :include, Crumby::Helper::ViewHelper
      end
    end
  end

end

Crumby.init!
