# encoding: utf-8
module Crumby

  # represent an entry of a breadcrumb menu
  class Entry < Struct.new(:trail, :position, :label, :route, :options)

    # Returns total entries
    # @return [Fixnum]
    def total
      trail.count
    end

    # Returns if first entry
    # @return [Boolean]
    def first?
      position.zero?
    end

    # Returns if last entry
    # @return [Boolean]
    def last?
      (total - position - 1).zero?
    end
  end

end
