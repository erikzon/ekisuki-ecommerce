class ProductsController < ApplicationController
  skip_before_action :protect_pages, only: [:index, :show]

  def index
    @product = Product.all
    if params[:query_text].present?
      @product = @product.search_full_text(params[:query_text])
    end
  end

  def new
    @product = Product.new()
  end

  def edit
    product
  end

  def update
    @product = Product.find(params[:id])
    @product.assign_attributes(product_params.except(:tags))
    create_or_delete_product_tags(@product, params[:product][:tags])
    if @product.tags.present?
      if @product.save
        redirect_to product_path(product.id), notice: "Producto editado correctamente"
      else
        redirect_to product_path(product.id), status: :unprocessable_entity, alert: "No se pudo editar el producto."
      end
    else
      redirect_to product_path(product.id), status: :unprocessable_entity, alert: "No se pudo editar el producto ya que no tiene tags."
    end
  end

  def show
    @categoryList = Category.all
    @product = Product.find(params[:id])
    category = Category.find(@product.category_id)
    @productCategoryName = category.name
    @selected_image_index = params[:selected_image_index].to_i || 0
    @tag = Tag.order("RANDOM()").limit(5)
    @quantity = 1
  end

  def destroy
    product.destroy!
    redirect_to root_path, notice: "Producto eliminado."
  end

  def create
    @Cart = Cart.all
    @product = Product.new(product_params.except(:tags))
    create_or_delete_product_tags(@product, params[:product][:tags])
    if @product.tags.present?
      if @product.save
        redirect_to admin_index_path, notice: "Producto creado correctamente"
      else
        redirect_to admin_index_path, status: :unprocessable_entity, alert: "No se pudo crear el producto."
      end
    else
      redirect_to admin_index_path, status: :unprocessable_entity, alert: "No se pudo crear el producto ya que no tiene tags."
    end
  end

  private

  def product
    @product = Product.find(params[:id])
  end

  def create_or_delete_product_tags(product, tags)
    product.taggings.destroy_all
    tags&.each do |tag|
      pp Tag.find_or_create_by(id: tag)
      product.tags << Tag.find_or_create_by(id: tag)
    end
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :category_id, photos: [], tags: [])
  end

end
