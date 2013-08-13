require 'test_helper'

class OmniauthCallbacksControllerTest < ActionController::TestCase
  test "should get vkontakte" do
    get :vkontakte
    assert_response :success
  end

  test "should get mailru" do
    get :mailru
    assert_response :success
  end

  test "should get odnoklassniki" do
    get :odnoklassniki
    assert_response :success
  end

end
