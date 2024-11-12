require "application_system_test_case"

class CatagoriesTest < ApplicationSystemTestCase
  setup do
    @catagory = catagories(:one)
  end

  test "visiting the index" do
    visit catagories_url
    assert_selector "h1", text: "Catagories"
  end

  test "should create catagory" do
    visit catagories_url
    click_on "New catagory"

    fill_in "Name", with: @catagory.name
    click_on "Create Catagory"

    assert_text "Catagory was successfully created"
    click_on "Back"
  end

  test "should update Catagory" do
    visit catagory_url(@catagory)
    click_on "Edit this catagory", match: :first

    fill_in "Name", with: @catagory.name
    click_on "Update Catagory"

    assert_text "Catagory was successfully updated"
    click_on "Back"
  end

  test "should destroy Catagory" do
    visit catagory_url(@catagory)
    click_on "Destroy this catagory", match: :first

    assert_text "Catagory was successfully destroyed"
  end
end
