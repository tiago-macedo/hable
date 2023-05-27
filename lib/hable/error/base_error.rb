# frozen_string_literal: true

class Hable::BaseError < StandardError
  attr_accessor :info

  def initialize(message = "Hable error :(", **info)
    @info = info
    super(message)
  end
end