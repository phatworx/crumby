module Crumby
  module Renderer
    autoload :Base, 'crumby/renderer/base'
    autoload :Haml, 'crumby/renderer/haml'

    def self.default_renderer
      Haml
    end
  end
end
