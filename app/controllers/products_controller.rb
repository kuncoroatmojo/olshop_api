class ProductsController < ApplicationController
  respond_to :json

  def index
    json_response(Product.all)
  end

  def show
    json_response(Product.find(params[:id]))
  end

  def create
    @product = Product.create(product_params)
    json_response(@product)
  end
end
