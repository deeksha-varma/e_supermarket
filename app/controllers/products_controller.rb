class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def show
    @product = Product.where(id: params[:id]).first
  end

  def edit
  	@product = Product.where(id: params[:id]).first
  end

  def update
  	@product = Product.where(id: params[:id]).first
    if @product.update_attributes(product_params)
      redirect_to @product
    else
      render 'edit'
    end
  end

  private

  def product_params
  	params.require(:product).permit(:name, :description, :price, :images, :sku_id, :expire_date, 
    :admin_approved, category_ids:[], categories_attributes: [:name])
  end
end