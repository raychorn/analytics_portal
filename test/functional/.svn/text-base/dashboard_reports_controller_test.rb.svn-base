require 'test_helper'

class DashboardReportsControllerTest < ActionController::TestCase
  setup do
    @dashboard_report = dashboard_reports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dashboard_reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dashboard_report" do
    assert_difference('DashboardReport.count') do
      post :create, :dashboard_report => @dashboard_report.attributes
    end

    assert_redirected_to dashboard_report_path(assigns(:dashboard_report))
  end

  test "should show dashboard_report" do
    get :show, :id => @dashboard_report.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @dashboard_report.to_param
    assert_response :success
  end

  test "should update dashboard_report" do
    put :update, :id => @dashboard_report.to_param, :dashboard_report => @dashboard_report.attributes
    assert_redirected_to dashboard_report_path(assigns(:dashboard_report))
  end

  test "should destroy dashboard_report" do
    assert_difference('DashboardReport.count', -1) do
      delete :destroy, :id => @dashboard_report.to_param
    end

    assert_redirected_to dashboard_reports_path
  end
end
