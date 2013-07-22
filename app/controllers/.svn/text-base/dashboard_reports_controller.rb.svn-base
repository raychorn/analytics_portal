class DashboardReportsController < ApplicationController
  load_and_authorize_resource

  # TODO fix me as this is hacky
  include DashboardsHelper

#  # GET /dashboard_reports
#  # GET /dashboard_reports.xml
#  def index
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @dashboard_reports }
#    end
#  end

#  # GET /dashboard_reports/1
#  # GET /dashboard_reports/1.xml
#  def show
#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @dashboard_report }
#    end
#  end

#  # GET /dashboard_reports/new
#  # GET /dashboard_reports/new.xml
#  def new
#    @dashboard_report = DashboardReport.new
#
#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @dashboard_report }
#    end
#  end

  # GET /dashboard_reports/1/edit
  def edit
    @dashboard_report.report.filter_param_associations.each do |filter_param_association|
      filter_param = filter_param_association.filter_param
      if @dashboard_report.filter_prefs.select{
          |filter_pref| filter_pref.filter_param == filter_param
      }.blank?
        @dashboard_report.filter_prefs.build(:filter_param_id => filter_param.id,
                                             :filter_param_association_id => filter_param_association.id)
      end
    end
  end

#  # POST /dashboard_reports
#  # POST /dashboard_reports.xml
#  def create
#    @dashboard_report = DashboardReport.new(params[:dashboard_report])
#
#    respond_to do |format|
#      if @dashboard_report.save
#        format.html { redirect_to(@dashboard_report, :notice => 'Dashboard report was successfully created.') }
#        format.xml  { render :xml => @dashboard_report, :status => :created, :location => @dashboard_report }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @dashboard_report.errors, :status => :unprocessable_entity }
#      end
#    end
#  end

  # PUT /dashboard_reports/1
  # PUT /dashboard_reports/1.xml
  def update
    respond_to do |format|
      owner_id = @dashboard_report.dashboard.owner_id
      @dashboard_report.filter_prefs.each do |filter_pref|
        # TODO let admins change other users' filter prefs
        filter_pref.user_id = owner_id
      end
      if @dashboard_report.update_attributes(params[:dashboard_report])
        format.html { redirect_to(@dashboard_report.dashboard, :notice => 'Dashboard report was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @dashboard_report.errors, :status => :unprocessable_entity }
      end
    end
  end

#  # DELETE /dashboard_reports/1
#  # DELETE /dashboard_reports/1.xml
#  def destroy
#    @dashboard_report = DashboardReport.find(params[:id])
#    @dashboard_report.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(dashboard_reports_url) }
#      format.xml  { head :ok }
#    end
#  end
end
