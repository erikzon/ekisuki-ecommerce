class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]
  skip_before_action :protect_pages, only: [:index, :show]
  # GET /categories/new
  def new
    @category = Category.new
  end

  def index
    @category = Category.all
    @tag = Tag.order("RANDOM()").limit(5)


    #producto mas vendido es el ID que mas se repite en los carritos que han sido vendidos
    @topSellerProduct = Product.find(Cart.where.not(order_id: nil)
                            .group(:product_id)
                            .order('count_product_id DESC')
                            .count('product_id')
                            .first
                          &.first)
  end

  # GET /categories/1/edit
  def show
    @categoryList = Category.all
    @tagLista = Tag.joins(:products => :category).where(:categories => { :id => @category }).distinct
    @tag = Tag.order("RANDOM()").limit(5)
    @product = Product.where(:category_id => @category)
  end

  # POST /categories or /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to admin_index_path, notice: "Categoria Creada." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    respond_to do |format|
      pp category_params
      if @category.update(category_params)
        format.html { redirect_to admin_index_path, notice: "Categoria actualizada." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.destroy

    respond_to do |format|
      format.html { redirect_to admin_index_path, notice: "Categoria eliminada." }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.require(:category).permit(:name, :photo, :isClothes)
  end
end
