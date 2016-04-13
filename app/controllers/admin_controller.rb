class AdminController < ApplicationController

  def index
    @part = Part.new
    @categories = Category.categories_with_parts
  end

end