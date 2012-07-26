module Crumby
  autoload :Entry, 'crumby/entry'
  autoload :Trail, 'crumby/trail'
  autoload :Helper, 'crumby/helper'
  autoload :Renderer, 'crumby/renderer'
end

ActiveSupport.on_load(:action_controller) do
  ActionController::Base.send :include, Crumby::Helper::ControllerHelper
end

ActiveSupport.on_load(:action_view) do
  ActionView::Base.send :include, Crumby::Helper::ViewHelper
end
