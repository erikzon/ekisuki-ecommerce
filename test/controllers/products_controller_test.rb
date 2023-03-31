require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get products_path
    assert_response :success
  end

  test 'allow to create a new product' do
    post products_path, params: {
      product: {
        title: 'otro Sticker naruto',
        description: 'tamano 4 x 5',
        price: 25,
        category_id: categories(:camisas).id,
        tags: tags(:naruto).id
      }
    }
    assert_equal flash[:notice], "Producto creado correctamente"
  end

  test 'does not allow to create a new product with empty fields' do
    post products_path, params: {
      product: {
        title: '',
        description: 'tamano 4 x 5',
        price: 25,
        category_id: categories(:camisas).id,
        tags: tags(:naruto).id
      }
    }
    assert_response :unprocessable_entity
    assert_equal flash[:alert], "No se pudo crear el producto."
  end

  test 'does not allow to create a new product without tags' do
    assert_no_difference('Product.count') do
      post products_path, params: {
        product: {
          title: 'fasdfas',
          description: 'tamano 4 x 5',
          price: 25,
          category_id: categories(:camisas).id,
          tags: nil
        }
      }
    end
    assert_equal flash[:alert], "No se pudo crear el producto ya que no tiene tags."
  end

end
