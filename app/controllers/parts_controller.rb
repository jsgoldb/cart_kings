class PartsController < ApplicationController

  def index
  end

  def new
    if params[:category_id] && !Category.exists?(params[:category_id])
      redirect_to (category_part_path(params[:id])), alert: "Category not found."
    else
      @category = Category.find_by(id: params[:category_id])
      @part = @category.parts.build
    end
  end

  def create
    @part = Part.find_or_create_by(description: params[:part][:description], category_id: params[:part][:category_id], price: params[:part][:price])
    @part.image = params[:part][:image]
    @part.save
    flash[:notice] = "Part successfully created."
    redirect_to category_part_path(@part.category, @part)
  end

  def edit
    part = Part.find(params[:id])
    @category = Category.find_by(id: params[:category_id])
    if @category.nil?
      redirect_to category_part_path(part), alert: "Category not found."
    else
      @part = @category.parts.find_by(id: params[:id])
      redirect_to category_part_path(part), alert: "Part not found." if @part.nil?
    end
  end

  def update
    @part = Part.find(params[:id])
    @part.update()
    flash[:notice] = "Part successfully updated."
    redirect_to category_part_path(@part.category, @part)
  end

  def show
    @category = Category.find(params[:category_id])
    @part = Part.find(params[:id])
  end

  def destroy
    @category = Category.find(params[:category_id])
    @part = Part.find(params[:id])
    @category.parts.find(@part).destroy
    flash[:notice] = "Part Deleted."
    redirect_to category_path(@category)
  end

  # private

  #   def part_params
  #     params.require(:part).permit(:description, :image, :category_id, :price)
  #   end

end
