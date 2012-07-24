# encoding: utf-8
module Crumby

  class Breadcrumb < Struct.new(:breadcrumbs, :position, :label, :route, :options)
    def total
      breadcrumbs.count
    end

    def first?
      position.zero?
    end

    def last?
      (total - position - 1).zero?
    end
  end

end
