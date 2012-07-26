# encoding: utf-8
module Crumby

  class Trail
    attr_reader :entries

    def initialize
      @entries = []
    end

    def count
      entries.count
    end

    def add(*args)
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

      entry = Entry.new(self, count, label, route, options)
      @entries << entry
      entry
    end

    def render(*args)
      options = args.extract_options!
      renderer_class = options[:renderer] || Renderer.default_renderer
      raise ArgumentError if not renderer_class.class == Class or not renderer_class.ancestors.include? Crumby::Renderer::Base
      view = args.first
      renderer_class.new(self, view, options).render
    end

    def title(*args)
      options = args.extract_options!
      suffix = args.first

      default_options = {
        divider: " » ",
        reverse: true,
        skip_first: true
      }
      options = default_options.merge args.extract_options!

      title_entries = entries
      title_entries = title_entries[1..-1] if options[:skip_first]

      title = title_entries.reverse.collect{ |e| e[:label] }
      title += [suffix] if suffix.present?
      title.join(options[:divider])
    end

  end

end
