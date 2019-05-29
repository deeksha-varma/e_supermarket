class Api::V1::ProductsController < ApplicationController
  protect_from_forgery with: :null_session, if: Proc.new {|c| c.request.format.json? }

  def create
    product = Product.new(product_params)
    image_params = params['product']['images']
    image_urls = []
    image_params.each do |param|
      image_urls << param['img_path']
    end  
    product.images = image_urls
    product.category_names = params[:product][:categories]
    if product.save
      render status: 200, json: { message: 'product created successfully!', data: product }
    else
      render status: 500, json: { message: 'product not saved', data: product.errors }
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :images, :sku_id, :expire_date, 
    :admin_approved, :category_names, category_ids:[], categories_attributes: [:name] )
  end  
end