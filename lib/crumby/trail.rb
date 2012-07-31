# encoding: utf-8
module Crumby

  # it represent on breadcrumb trail
  class Trail
    attr_reader :entries

    def initialize
      @entries = []
    end

    # Returns total entries
    # @return [Fixnum] total entries
    def count
      entries.count
    end

    # add a new entry
    # @example
    #   add :books
    #   add @book
    #   add [:admin, @book]
    #   add "Books", :admin_books
    #   add "Books", [:admin,:books]
    #   add "Book", [:admin, @book]
    #   add "Google", "http://google.de"
    # @overload render(combined)
    #   @param [Object] combined
    # @overload render(label, route)
    #   @param [String] label the label passthrough to link_to
    #   @param [Symbol, Array, String] route route passthrough to link_to
    #
    # @return [Crumby::Entry] builded entry
    def add(*args)
      # extract options
      options = args.extract_options!

      # call without any arguments
      raise ArgumentError, "Need arguments." if args.empty?

      # process arguments
      if args.count == 1
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

    # render the trail by a renderer
    # @overload render(view, options)
    #   @param [ActionView::Base] view
    #   @param [Hash] options passthrough to renderer
    #   @option options [Class] :renderer overwrite default renderer
    #
    # @return [String] rendered trail
    def render(*args)
      options = args.extract_options!
      renderer_class = options[:renderer] || Crumby::Renderer.default_renderer
      raise ArgumentError if not renderer_class.class == Class or not renderer_class.ancestors.include? Crumby::Renderer::Base
      view = args.first
      renderer_class.new(self, view, options).render
    end

    # build a title of trail e.g. for page title
    # @example
    #   title
    #   title "The Site"
    #   title "The Site", divider: " - "
    # @overload title(suffix, options)
    #   @param [String] suffix last item.
    #   @param [Hash] options
    #   @option options [String] :divider The divider. default is " » "
    #   @option options [Boolean] :reverse reverse the title building. default is true
    #   @option options [Boolean] :skip_first remove first entry. it is usefull
    #
    # @return [String] build title. e.g New Book » Books » Admin
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

      if title_entries.count > 0
        title = title_entries.reverse.collect{ |e| e[:label] }
        title += [suffix] if suffix.present?
        title.join(options[:divider])
      else
        suffix.to_s
      end
    end

  end

end
