class AdminController < ApplicationController

  def index
    @part = Part.new
  end

end