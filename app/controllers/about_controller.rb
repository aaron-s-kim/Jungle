class AboutController < ApplicationController

  # add this line to any controller you want secured
  # will force user login before seeing actions in this controller
  before_filter :authorize

  def index
  end
end
