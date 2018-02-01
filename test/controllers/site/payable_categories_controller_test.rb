require 'test_helper'

class Site::PayableCategoriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
