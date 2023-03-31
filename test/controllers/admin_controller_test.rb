require "test_helper"

class AdminControllerTest < ActionDispatch::IntegrationTest

  test "should get admin access" do
    loginAdmin
    get admin_index_url
    assert_response :success
  end

  test "should not get admin access" do
    login
    get admin_index_url
    assert_redirected_to products_path
  end
end
