module CategoriesHelper
  def category_route(category)
    if category.parent_category_id
      return 'categories/<%= category.id %>'
    end
  end
end
