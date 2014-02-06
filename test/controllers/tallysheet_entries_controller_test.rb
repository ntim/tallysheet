require 'test_helper'

class TallysheetEntriesControllerTest < ActionController::TestCase
  setup do
    @tallysheet_entry = tallysheet_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tallysheet_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tallysheet_entry" do
    assert_difference('TallysheetEntry.count') do
      post :create, tallysheet_entry: { amount: @tallysheet_entry.amount, beverage_id: @tallysheet_entry.beverage_id, consumer_id: @tallysheet_entry.consumer_id }
    end

    assert_redirected_to tallysheet_entry_path(assigns(:tallysheet_entry))
  end

  test "should show tallysheet_entry" do
    get :show, id: @tallysheet_entry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tallysheet_entry
    assert_response :success
  end

  test "should update tallysheet_entry" do
    patch :update, id: @tallysheet_entry, tallysheet_entry: { amount: @tallysheet_entry.amount, beverage_id: @tallysheet_entry.beverage_id, consumer_id: @tallysheet_entry.consumer_id }
    assert_redirected_to tallysheet_entry_path(assigns(:tallysheet_entry))
  end

  test "should destroy tallysheet_entry" do
    assert_difference('TallysheetEntry.count', -1) do
      delete :destroy, id: @tallysheet_entry
    end

    assert_redirected_to tallysheet_entries_path
  end
end
