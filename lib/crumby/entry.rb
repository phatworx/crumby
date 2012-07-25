# encoding: utf-8
module Crumby

  class Entry < Struct.new(:trail, :position, :label, :route, :options)
    def total
      trail.count
    end

    def first?
      position.zero?
    end

    def last?
      (total - position - 1).zero?
    end
  end

end
