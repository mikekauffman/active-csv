require 'csv'

module ActiveCSV
  class Base
    def initialize(*row)
      @row = cleaned_headers(row)
    end

    def method_missing(method_name)
      if @row.has_key?(method_name.to_s)
        @row[method_name.to_s]
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      @row.has_key?(method_name.to_s) || super
    end

    private

    def cleaned_headers(row)
      if row.first
        headers = row.first.headers.map {|header| header.strip.downcase.split(" ").join("_")}
        values = row.first.fields
        CSV::Row.new(headers, values)
      end
    end

  end
end