class PartsController < ApplicationController

  def index
  end

  def new
    if !Category.exists?(params[:category_id])
      redirect_to (category_part_path(params[:id])), alert: "Category not found."
    else
      @category = Category.find_by(id: params[:category_id])
      @part = @category.parts.build
    end
  end

  def create
    @part = Part.create(part_params)
    @part.save
    if !@part.category
      @part.category = Category.find_by(name: params[:part][:category])
      @part.save
    end
    flash[:notice] = "Part successfully created."
    if !@part.errors.empty?
      raise @part.errors.inspect
    end
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
    @part.update(part_params)
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

  private

    def part_params
      params.require(:part).permit(:description, :image, :category_id, :price, :category_name)
    end

end
