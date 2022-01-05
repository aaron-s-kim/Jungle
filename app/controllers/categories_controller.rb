class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    # raise @category.inspect # throw/raises an error (like a breakpoint)
    @products = @category.products.order(created_at: :desc)
  end

end
