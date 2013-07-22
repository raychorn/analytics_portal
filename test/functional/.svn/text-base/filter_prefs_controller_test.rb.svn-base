require 'test_helper'

class FilterPrefsControllerTest < ActionController::TestCase
  setup do
    @filter_pref = filter_prefs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:filter_prefs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create filter_pref" do
    assert_difference('FilterPref.count') do
      post :create, :filter_pref => @filter_pref.attributes
    end

    assert_redirected_to filter_pref_path(assigns(:filter_pref))
  end

  test "should show filter_pref" do
    get :show, :id => @filter_pref.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @filter_pref.to_param
    assert_response :success
  end

  test "should update filter_pref" do
    put :update, :id => @filter_pref.to_param, :filter_pref => @filter_pref.attributes
    assert_redirected_to filter_pref_path(assigns(:filter_pref))
  end

  test "should destroy filter_pref" do
    assert_difference('FilterPref.count', -1) do
      delete :destroy, :id => @filter_pref.to_param
    end

    assert_redirected_to filter_prefs_path
  end
end
