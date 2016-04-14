class CategoriesController < ApplicationController

  before_action :is_admin?, only: [:new, :create, :edit, :update, :destroy]

  def index
    @categories = Category.where(parent_category_id: nil)
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def show
    @category = Category.find(params[:id])
  end

  def destroy
  end

end
