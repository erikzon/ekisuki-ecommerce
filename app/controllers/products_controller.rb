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
      redirect_to products_path, notice: "Producto creado correctamente"
    else
      redirect_to admin_index_path, status: :unprocessable_entity, alert: "No se pudo crear el producto."
    end
  end


  private

  def product_params
    params.require(:product).permit(:title, :description, :price, :category_id, photos: [], tags_id: [])
  end

end