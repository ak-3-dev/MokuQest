require "test_helper"

class Admin::CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get index" do
    sign_in admins(:one)

    get admin_comments_index_url

    assert_response :success
  end
end
