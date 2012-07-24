module Crumby
  autoload :Breadcrumb, 'crumby/breadcrumb'
  autoload :Breadcrumbs, 'crumby/breadcrumbs'
  autoload :Helper, 'crumby/helper'
  autoload :Renderer, 'crumby/renderer'

  # module Helper
  #   extend ActiveSupport::Concern

  #   included do
  #     # if respond_to? :helper_method
  #     #   helper_method :crumb_title
  #     # end
  #   end

  #   # get breadcrumb
  #   # def breadcrumb(scope = :default)
  #   #   @breadcrumb_scopes = {} if @breadcrumb_scopes.nil?
  #   #   @breadcrumb_scopes[scope] ||= Breadcrumbs.new
  #   # end

  #   # def breadcrumbs(*args)
  #   #   breadcrumbs.render(*args)
  #   # end

  #   # # controller helper
  #   # def add_crumb(*args)
  #   #   breadcrumb.add *args
  #   # end

  #   # # view helper
  #   # def crumb_title(*args)
  #   #   breadcrumb.title *args
  #   # end

  #   # def breadcrumb_tail(scope = :default)

  #   # end


  #     # default_options = {
  #     #   divider: " » ",
  #     #   skip_first: true
  #     # }
  #     # options = default_options.merge args.extract_options!

  #     # suffix = args.first || nil

  #     # items = @crumby_items
  #     # items = items[1..-1] if options[:skip_first]

  #     # title = items.reverse.collect{ |e| e[:label] }
  #     # title += [suffix] if suffix.present?
  #     # title.join(options[:divider])

  #   # def crumby(*args)
  #   #   default_options = {
  #   #     divider: "/",
  #   #     link_last: false,
  #   #     link_first: true
  #   #   }
  #   #   options = default_options.merge args.extract_options!

  #   #   item_count = @crumby_items.count
  #   #   capture_haml do
  #   #     haml_tag :ul, class: "breadcrumb" do
  #   #       @crumby_items.each_with_index do |crumb, cnt|
  #   #         last = (cnt == item_count - 1)
  #   #         first = (cnt == 0)

  #   #         haml_tag :li, class: (last ? 'active' : nil) do

  #   #           if crumb[:route].nil? or (last and not options[:link_last]) or (first and not options[:link_first])
  #   #             haml_concat crumb[:label]
  #   #           else
  #   #             haml_concat link_to(crumb[:label], crumb[:route])
  #   #           end

  #   #           haml_tag "span.divider", options[:divider] unless last

  #   #         end
  #   #       end
  #   #     end
  #   #   end
  #   # end
  # end

  # module Controller
  #   extend ActiveSupport::Concern

  #   module ClassMethods
  #   end

  #   included do
  #     helper_method :crumbs
  #     helper Crumby::Helper
  #   end

  #   def crumby_items
  #     @crumby_items ||= []
  #   end

  #   def add_crumb(*args)
  #     options = args.extract_options!
  #     if args.empty?
  #       raise ArgumentError, "Need arguments."
  #     elsif args.count == 1
  #       value = args.first
  #       if value.is_a? String
  #         label = value
  #       elsif value.is_a? Symbol
  #         label = value.to_s.humanize
  #         route = value
  #       elsif value.respond_to? :model_name
  #         label = value.model_name.human
  #         route = value
  #       elsif value.kind_of? Array
  #         if value.last.respond_to? :model_name
  #           label = value.last.model_name.human
  #         else
  #           label = value.last.to_s.humanize
  #         end
  #         route = value
  #       else
  #         label = value.to_s.humanize
  #       end
  #     else
  #       label = args.first
  #       route = args.second
  #     end
  #     crumby_items << { label: label, route: route, options: options }
  #   end
  # end
end

ActionController::Base.send :include, Crumby::Helper if defined? ActionController
