require "test_helper"

class Jumpstart::StaticTest < ActionDispatch::IntegrationTest
  setup do
    @account = accounts(:company)
    @admin = users(:one)
    @regular_user = users(:two)
    @track = tracks(:one)
    sign_in @admin
  end

  test "homepage" do
    get root_path
    assert_response :success
  end

  test "dashboard" do
    sign_in users(:one)
    get root_path
    assert_response :success
  end
end
