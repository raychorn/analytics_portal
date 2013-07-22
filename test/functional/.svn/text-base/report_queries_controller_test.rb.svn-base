require 'test_helper'

class ReportQueriesControllerTest < ActionController::TestCase
  setup do
    @report_query = report_queries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:report_queries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create report_query" do
    assert_difference('ReportQuery.count') do
      post :create, :report_query => @report_query.attributes
    end

    assert_redirected_to report_query_path(assigns(:report_query))
  end

  test "should show report_query" do
    get :show, :id => @report_query.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @report_query.to_param
    assert_response :success
  end

  test "should update report_query" do
    put :update, :id => @report_query.to_param, :report_query => @report_query.attributes
    assert_redirected_to report_query_path(assigns(:report_query))
  end

  test "should destroy report_query" do
    assert_difference('ReportQuery.count', -1) do
      delete :destroy, :id => @report_query.to_param
    end

    assert_redirected_to report_queries_path
  end
end
