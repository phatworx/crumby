# encoding: utf-8
module Crumby

  module Helper
    extend ActiveSupport::Concern

    def crumby_title(*args)
      options = args.extract_options!
      options.merge({
        divider: " » ",
        skip_first: true
      })

      p options.inspect

      suffix = args.first || nil

      items = @crumb_items
      items = items[1..-1] if options[:skip_first]

      title = items.reverse.collect{ |e| e[:label] }
      title += [suffix] if suffix.present?
      title.join(options[:divider])
    end

    def crumby(*args)
      options = args.extract_options!
      options.merge({
        divider: "/",
        link_last: false,
        link_first: true
      })
      p options.inspect

      item_count = @crumb_items.count
      capture_haml do
        haml_tag :ul, class: "breadcrumb" do
          @crumb_items.each_with_index do |crumb, cnt|
            last = (cnt == item_count - 1)
            first = (cnt == 0)

            haml_tag :li, class: (last ? 'active' : nil) do

              if crumb[:route].nil? or (last and not options[:link_last]) or (first and not options[:link_first])
                haml_concat crumb[:label]
              else
                haml_concat link_to(crumb[:label], crumb[:route])
              end

              haml_tag "span.divider", options[:divider] unless last

            end
          end
        end
      end
    end
  end

  module Controller
    extend ActiveSupport::Concern

    module ClassMethods
    end

    included do
      helper_method :crumbs
      helper Crumby::Helper
    end

    def crumb_items
      @crumb_items ||= []
    end

    def add_crumb(*args)
      options = args.extract_options!
      if args.empty?
        raise ArgumentError, "Need arguments."
      elsif args.count == 1
        value = args.first
        if value.is_a? String
          label = value
        elsif value.is_a? Symbol
          label = value.to_s.humanize
          route = value
        elsif value.respond_to? :model_name
          label = value.model_name.human
          route = value
        elsif value.kind_of? Array
          if value.last.respond_to? :model_name
            label = value.last.model_name.human
          else
            label = value.last.to_s.humanize
          end
          route = value
        else
          label = value.to_s.humanize
        end
      else
        label = args.first
        route = args.second
      end
      crumb_items << { label: label, route: route, options: options }
    end
  end
end

ActionController::Base.send :include, Crumby::Controller if defined? ActionController
