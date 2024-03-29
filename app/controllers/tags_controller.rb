class TagsController < ApplicationController
  before_action :set_tag, only: %i[ show edit update destroy ]
  skip_before_action :protect_pages, only: [:index, :show]
  # GET /tags/new
  def new
    @tag = Tag.new
  end

  # GET /tags/1/edit
  def edit
  end

  def show
    @categoryList = Category.all
    @category = Product.joins(:taggings => :tag).where(:tags => { :id => @tag }).distinct
    @product = Product.joins(:taggings => :tag).where(:tags => { :id => @tag }).distinct
    @tagName = @tag.name
  end

  # POST /tags
  def create
    @tag = Tag.new(tag_params)

    respond_to do |format|
      if @tag.save
        format.html { redirect_to admin_index_path, notice: "Tag Creado." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tags/1
  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.html { redirect_to admin_index_path, notice: "Tag actualizada." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tag/1
  def destroy
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to admin_index_path, notice: "Tag eliminado." }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_tag
    @tag = Tag.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def tag_params
    params.require(:tag).permit(:name, :photo)
  end
end