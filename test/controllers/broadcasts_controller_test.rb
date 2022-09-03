require "test_helper"

class BroadcastsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @broadcast = broadcasts(:one)
  end

  test "should get index" do
    get broadcasts_url
    assert_response :success
  end

  test "should get new" do
    get new_broadcast_url
    assert_response :success
  end

  test "should create broadcast" do
    assert_difference("Broadcast.count") do
      post broadcasts_url, params: { broadcast: { name: @broadcast.name, preview: @broadcast.preview, recipients_group: @broadcast.recipients_group, send_at: @broadcast.send_at, sender_email: @broadcast.sender_email, sender_name: @broadcast.sender_name, subject: @broadcast.subject } }
    end

    assert_redirected_to broadcast_url(Broadcast.last)
  end

  test "should show broadcast" do
    get broadcast_url(@broadcast)
    assert_response :success
  end

  test "should get edit" do
    get edit_broadcast_url(@broadcast)
    assert_response :success
  end

  test "should update broadcast" do
    patch broadcast_url(@broadcast), params: { broadcast: { name: @broadcast.name, preview: @broadcast.preview, recipients_group: @broadcast.recipients_group, send_at: @broadcast.send_at, sender_email: @broadcast.sender_email, sender_name: @broadcast.sender_name, subject: @broadcast.subject } }
    assert_redirected_to broadcast_url(@broadcast)
  end

  test "should destroy broadcast" do
    assert_difference("Broadcast.count", -1) do
      delete broadcast_url(@broadcast)
    end

    assert_redirected_to broadcasts_url
  end
end
