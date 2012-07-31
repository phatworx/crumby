# renderer package
module Crumby::Renderer
  autoload :Base, 'crumby/renderer/base'
  autoload :Haml, 'crumby/renderer/haml'

  # Returns the default renderer
  # @return [Crumby::Renderer::Base]
  def self.default_renderer
    Crumby.renderer
  end
end
