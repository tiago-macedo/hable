# frozen_string_literal: true

module Hable
  class Table
    attr_reader :header, :stub
    attr_accessor :data

    def initialize
      @data = Hash.new
      @stub = []
    end

    def data
      @data
    end

    def data= new_data
      @data = new_data
    end

    def head *columns
      raise BaseError unless @data.empty? # TODO: add error

      @header = columns
      columns.each { |column_name| @data[column_name] = {} }
    end
      

    def row label, *data
      raise BaseError if @stub.include? label # TODO: add error

      @stub << label
      data.each_with_index do |datum, idx|
        column = header[idx]
        @data[column][label] = datum
      end
    end

    def get_row(label)
      data.map { |column_name, column| [column_name, column[label]] }.to_h
    end

    def at(*args)
      arg = args.first
      case arg
      when Integer then return get_row stub[arg]
      when Hash    then return at_hash arg[:col], arg[:row]
      end

      raise ArgumentError, "Method #at does not accept type #{arg.class}"
    end

    def [] column, row
      @data.dig column, row
    end

    private

    def at_hash col, row
      return @data[header[col]]             if col && !row
      return get_row stub[row]              if row && !col
      return @data.dig arg[:col], arg[:row] if row && col
      
      raise ArgumentError, "Method #at does not accept type #{arg.class}"
    end
  end
end