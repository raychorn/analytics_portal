require 'test_helper'

class DataSegmentsControllerTest < ActionController::TestCase
  setup do
    @data_segment = data_segments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:data_segments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create data_segment" do
    assert_difference('DataSegment.count') do
      post :create, :data_segment => @data_segment.attributes
    end

    assert_redirected_to data_segment_path(assigns(:data_segment))
  end

  test "should show data_segment" do
    get :show, :id => @data_segment.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @data_segment.to_param
    assert_response :success
  end

  test "should update data_segment" do
    put :update, :id => @data_segment.to_param, :data_segment => @data_segment.attributes
    assert_redirected_to data_segment_path(assigns(:data_segment))
  end

  test "should destroy data_segment" do
    assert_difference('DataSegment.count', -1) do
      delete :destroy, :id => @data_segment.to_param
    end

    assert_redirected_to data_segments_path
  end
end
