require 'test_helper'

class TrackingControllerTest < ActionController::TestCase
  test "should get followers" do
    get :followers
    assert_response :success
  end

  test "should get followed_by" do
    get :followed_by
    assert_response :success
  end

  test "should get followed_by_shop" do
    get :followed_by_shop
    assert_response :success
  end

end
