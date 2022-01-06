class Admin::DashboardController < ApplicationController
  
  def show
    @products = Product.all.order(created_at: :desc)
    @categories = Category.all.order(created_at: :desc)
    @product_count = Product.all.order(created_at: :desc).count
    @category_count = Category.all.order(created_at: :desc).count
  end
end
