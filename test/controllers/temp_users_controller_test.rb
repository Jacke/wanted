require 'test_helper'

class TempUsersControllerTest < ActionController::TestCase
  test "should get init" do
    get :init
    assert_response :success
  end

  test "should get update" do
    get :update
    assert_response :success
  end

end
