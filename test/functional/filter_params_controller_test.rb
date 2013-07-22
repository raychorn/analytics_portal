require 'test_helper'

class FilterParamsControllerTest < ActionController::TestCase
  setup do
    @filter_param = filter_params(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:filter_params)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create filter_param" do
    assert_difference('FilterParam.count') do
      post :create, :filter_param => @filter_param.attributes
    end

    assert_redirected_to filter_param_path(assigns(:filter_param))
  end

  test "should show filter_param" do
    get :show, :id => @filter_param.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @filter_param.to_param
    assert_response :success
  end

  test "should update filter_param" do
    put :update, :id => @filter_param.to_param, :filter_param => @filter_param.attributes
    assert_redirected_to filter_param_path(assigns(:filter_param))
  end

  test "should destroy filter_param" do
    assert_difference('FilterParam.count', -1) do
      delete :destroy, :id => @filter_param.to_param
    end

    assert_redirected_to filter_params_path
  end
end
