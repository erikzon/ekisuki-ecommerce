require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get products_index_url
    assert_response :success
  end

  test 'renders a new product form' do
    get new_product_path

    assert_response :success
    assert_select 'form'
  end

  test 'allow to create a new product' do
    post products_path, params: {
      product: {
        title: 'Sticker Zelda',
        description: 'tamano 4 x 5',
        price: 25
      }
    }

    assert_redirected_to new_product_path
    assert_equal flash[:notice], "Producto creado correctamente"
  end

  test 'does not allow to create a new product with empty fields' do
    post products_path, params: {
      product: {
        title: '',
        description: 'tamano 4 x 5',
        price: 25
      }
    }

    assert_response :unprocessable_entity
  end

end
