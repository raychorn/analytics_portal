require 'test_helper'

class FilterSetsControllerTest < ActionController::TestCase
  setup do
    @filter_set = filter_sets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:filter_sets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create filter_set" do
    assert_difference('FilterSet.count') do
      post :create, :filter_set => @filter_set.attributes
    end

    assert_redirected_to filter_set_path(assigns(:filter_set))
  end

  test "should show filter_set" do
    get :show, :id => @filter_set.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @filter_set.to_param
    assert_response :success
  end

  test "should update filter_set" do
    put :update, :id => @filter_set.to_param, :filter_set => @filter_set.attributes
    assert_redirected_to filter_set_path(assigns(:filter_set))
  end

  test "should destroy filter_set" do
    assert_difference('FilterSet.count', -1) do
      delete :destroy, :id => @filter_set.to_param
    end

    assert_redirected_to filter_sets_path
  end
end
