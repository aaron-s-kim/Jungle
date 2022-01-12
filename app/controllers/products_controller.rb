class ProductsController < ApplicationController

  def index
    # uses MODEL
    @products = Product.all.order(created_at: :desc)
    # VIEW
    # render :index # implicitly renders view template
  end

  def show
    @product = Product.find params[:id]
    
    # @msg = "Hello"
    # instance vars are magically transferred from controller to be available in all templates rendered as part of this request response
    # render :show # can also use string for path, ex. 'shared/show'
  end

end
