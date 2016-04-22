require 'test_helper'

class StaticFlashesControllerTest < ActionController::TestCase
  setup do
    @static_flash = static_flashes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:static_flashes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create static_flash" do
    assert_difference('StaticFlash.count') do
      post :create, static_flash: { content: @static_flash.content, expires: @static_flash.expires }
    end

    assert_redirected_to static_flash_path(assigns(:static_flash))
  end

  test "should show static_flash" do
    get :show, id: @static_flash
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @static_flash
    assert_response :success
  end

  test "should update static_flash" do
    patch :update, id: @static_flash, static_flash: { content: @static_flash.content, expires: @static_flash.expires }
    assert_redirected_to static_flash_path(assigns(:static_flash))
  end

  test "should destroy static_flash" do
    assert_difference('StaticFlash.count', -1) do
      delete :destroy, id: @static_flash
    end

    assert_redirected_to static_flashes_path
  end
end
