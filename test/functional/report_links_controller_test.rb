require 'test_helper'

class ReportLinksControllerTest < ActionController::TestCase
  setup do
    @report_link = report_links(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:report_links)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create report_link" do
    assert_difference('ReportLink.count') do
      post :create, :report_link => @report_link.attributes
    end

    assert_redirected_to report_link_path(assigns(:report_link))
  end

  test "should show report_link" do
    get :show, :id => @report_link.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @report_link.to_param
    assert_response :success
  end

  test "should update report_link" do
    put :update, :id => @report_link.to_param, :report_link => @report_link.attributes
    assert_redirected_to report_link_path(assigns(:report_link))
  end

  test "should destroy report_link" do
    assert_difference('ReportLink.count', -1) do
      delete :destroy, :id => @report_link.to_param
    end

    assert_redirected_to report_links_path
  end
end
