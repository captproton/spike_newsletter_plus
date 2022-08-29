require "test_helper"

class BroadcastPartsControllerTest < ActionDispatch::IntegrationTest
  test "should get assign_settings" do
    get broadcast_parts_assign_settings_url
    assert_response :success
  end

  test "should get create_content" do
    get broadcast_parts_create_content_url
    assert_response :success
  end

  test "should get confirm_values" do
    get broadcast_parts_confirm_values_url
    assert_response :success
  end
end
