require "test_helper"

class StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_index_url
    assert_response :success
    assert_select 'h1', 'Welcome to the Store'
    assert_select '.product', 3
    assert_select '.price', /\$[,\d]+\.\d\d/
  end
end
