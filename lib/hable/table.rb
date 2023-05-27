# frozen_string_literal: true

module Hable
  class Table
    attr_reader :header, :stub
    attr_accessor :data

    def initialize
      @data = Hash.new
    end

    def data
      @data
    end

    def data=(new_data)
      @data = new_data
    end

    def head(*columns)
      fail unless @data.empty? # TODO: add error

      @header = columns
      columns.each { |column_name| @data[column_name] = {} }
    end
      

    def row(lable, *data)
      data.each_with_index do |datum, idx|
        column = header[idx]
        @data[column][lable] = datum
      end
    end

    def [](column, row)
      @data.dig(column, row)
    end
  end
end