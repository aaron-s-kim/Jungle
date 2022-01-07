class Admin::SalesController < ApplicationController

  def index
    @sales = Sale.all
    # render :index # implicit
  end

end
