class ProductsController < ApplicationController
  def index
    @product = Product.all
  end

  def new
    @product = Product.new()
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to new_product_path, notice: "Producto creado correctamente"
    else
      redirect_to admin_index_path, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, :category_id, photos: [])
  end

end
