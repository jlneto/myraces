require "application_system_test_case"

class TracksTest < ApplicationSystemTestCase
  setup do
    @track = tracks(:one)
  end

  test "visiting the index" do
    visit tracks_url
    assert_selector "h1", text: "Tracks"
  end

  test "creating a Track" do
    visit tracks_url
    click_on "New Track"

    fill_in "Location", with: @track.location
    fill_in "Name", with: @track.name
    click_on "Create Track"

    assert_text "Track was successfully created"
    assert_selector "h1", text: "Tracks"
  end

  test "updating a Track" do
    visit track_url(@track)
    click_on "Edit", match: :first

    fill_in "Location", with: @track.location
    fill_in "Name", with: @track.name
    click_on "Update Track"

    assert_text "Track was successfully updated"
    assert_selector "h1", text: "Tracks"
  end

  test "destroying a Track" do
    visit edit_track_url(@track)
    click_on "Delete", match: :first
    click_on "Confirm"

    assert_text "Track was successfully destroyed"
  end
end
