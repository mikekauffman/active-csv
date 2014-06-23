require 'csv'

module ActiveCSV
  class Base
    def initialize(*row)
      @row = row
    end

    def method_missing(method_name)
      @row.first[method_name.to_s] || super
    end

    def respond_to_missing?(method_name, include_private = false)
      !@row.first[method_name.to_s].nil? || super
    end
  end
end