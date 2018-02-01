require 'test_helper'

class Site::CustomersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
