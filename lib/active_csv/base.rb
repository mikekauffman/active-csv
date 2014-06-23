require 'csv'

module ActiveCSV
  class Base
    def initialize(*row)
      @row = row
    end

    def method_missing(method_name)
      if @row.first[method_name.to_s]
        @row.first[method_name.to_s]
      elsif @row.first[method_name.to_s].nil?
        nil
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      @row.first.headers.include?(method_name.to_s) || super
    end
  end
end