class ProductsController < ApplicationController
  skip_before_action :protect_pages, only: [:index, :show]
  def index
    @product = Product.all
  end

  def new
    @product = Product.new()
  end

  def create
    @product = Product.new(product_params.except(:tags))
    create_or_delete_product_tags(@product, params[:product][:tags])
    if @product.save
      redirect_to admin_index_path, notice: "Producto creado correctamente"
    else
      redirect_to admin_index_path, status: :unprocessable_entity, alert: "No se pudo crear el producto."
    end
  end

  private

  def create_or_delete_product_tags(product, tags)
    product.taggings.destroy_all
    #cambiar esto por un iterados de array
    tags.each do |tag|
      pp Tag.find_or_create_by(id: tag)
      product.tags << Tag.find_or_create_by(id: tag)
    end
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :category_id, photos: [], tags: [])
  end

end
