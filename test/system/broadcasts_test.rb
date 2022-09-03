require "application_system_test_case"

class BroadcastsTest < ApplicationSystemTestCase
  setup do
    @broadcast = broadcasts(:one)
  end

  test "visiting the index" do
    visit broadcasts_url
    assert_selector "h1", text: "Broadcasts"
  end

  test "should create broadcast" do
    visit broadcasts_url
    click_on "New broadcast"

    fill_in "Name", with: @broadcast.name
    fill_in "Preview", with: @broadcast.preview
    fill_in "Recipients group", with: @broadcast.recipients_group
    fill_in "Send at", with: @broadcast.send_at
    fill_in "Sender email", with: @broadcast.sender_email
    fill_in "Sender name", with: @broadcast.sender_name
    fill_in "Subject", with: @broadcast.subject
    click_on "Create Broadcast"

    assert_text "Broadcast was successfully created"
    click_on "Back"
  end

  test "should update Broadcast" do
    visit broadcast_url(@broadcast)
    click_on "Edit this broadcast", match: :first

    fill_in "Name", with: @broadcast.name
    fill_in "Preview", with: @broadcast.preview
    fill_in "Recipients group", with: @broadcast.recipients_group
    fill_in "Send at", with: @broadcast.send_at
    fill_in "Sender email", with: @broadcast.sender_email
    fill_in "Sender name", with: @broadcast.sender_name
    fill_in "Subject", with: @broadcast.subject
    click_on "Update Broadcast"

    assert_text "Broadcast was successfully updated"
    click_on "Back"
  end

  test "should destroy Broadcast" do
    visit broadcast_url(@broadcast)
    click_on "Destroy this broadcast", match: :first

    assert_text "Broadcast was successfully destroyed"
  end
end
