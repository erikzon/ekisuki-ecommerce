require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    loginAdmin
    @category = categories(:camisas)
  end

  test "should get new" do
    get new_category_url
    assert_response :success
  end

  test "should create category" do
    assert_difference("Category.count") do
      post categories_url, params: { category: { name: @category.name } }
    end
    assert_redirected_to admin_index_path
  end

  test "should get edit" do
    get edit_category_url(@category)
    assert_response :success
  end

  test "should update category" do
    patch category_url(@category), params: { category: { name: @category.name } }
    assert_redirected_to admin_index_path
  end

  test "should destroy category" do
    assert_difference("Category.count", -1) do
      delete category_url(categories(:sinuso).id)
    end

    assert_redirected_to admin_index_path
  end
end
