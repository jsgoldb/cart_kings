class AdminController < ApplicationController

  before_action :authenticate_user!
  before_action :is_admin?

  def index
    @part = Part.new
    @categories = Category.categories_with_parts
  end

end