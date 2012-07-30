module Crumby
  autoload :Entry, 'crumby/entry'
  autoload :Trail, 'crumby/trail'
  autoload :Helper, 'crumby/helper'
  autoload :Renderer, 'crumby/renderer'


  # default renderer
  mattr_accessor :renderer
  @@renderer = Renderer::Haml

  class << self
    def setup
      yield self
    end
  end

end

ActiveSupport.on_load(:action_controller) do
  ActionController::Base.send :include, Crumby::Helper::ControllerHelper
end

ActiveSupport.on_load(:action_view) do
  ActionView::Base.send :include, Crumby::Helper::ViewHelper
end
