class ReportsController < ApplicationController

  load_and_authorize_resource

  set_tab :analytics
  set_tab :reports, :sub_nav
  before_filter do
    @sub_nav_group = :analytics
  end

  # GET /reports
  # GET /reports.xml
  def index
    respond_to do |format|
      format.html { render :layout => 'two_col' } # index.html.erb
      format.xml  { render :xml => @reports }
    end
  end

  # GET /reports/1
  # GET /reports/1.xml
  def show
    @reports = Report.accessible_by(current_ability).search(params[:search])
    @displayed_reports = [@report]

    respond_to do |format|
      format.html { render :layout => 'two_col' }
      format.xml  { render :xml => @report }
    end
  end

  # GET /reports/new
  # GET /reports/new.xml
  def new
    render_new_subclass = false
    @report_type = params[:report_type]
    if Report.report_subclasses_strings.include? @report_type
      @report = @report_type.constantize.new
      @report.report_type = @report_type
      render_new_subclass = true
    else
      @report = Report.new
    end

    respond_to do |format|
      if render_new_subclass
        format.html { render_report @report, :template => 'new' }
        format.xml  { render :xml => @report }
      else
        format.html # new.html.erb
        format.xml  { render :xml => @report }
      end
    end
  end

  # GET /reports/1/edit
  def edit
    @report.filter_param_associations.each do |filter_param_association|
      if filter_param_association.filter_prefs.blank?
        @report.filter_prefs.build(:filter_param_association_id => filter_param_association.id)
      end
    end
  end

  # POST /reports
  # POST /reports.xml
  def create
    @report_type = params[:report][:report_type] if params[:report]
    if Report.report_subclasses_strings.include? @report_type
      @report = Report.new(params[:report])
      @report = @report_type.constantize.new(params[:report])
      @report.report_type = @report_type
    else
      @report = Report.new(params[:report])
    end

    respond_to do |format|
      if @report.save
        format.html { redirect_to(@report, :notice => 'Report was successfully created.') }
        format.xml  { render :xml => @report, :status => :created, :location => @report }
      else
        format.html { render_report @report, :template => "new" }
        format.xml  { render :xml => @report.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /reports/1
  # PUT /reports/1.xml
  def update
    respond_to do |format|
      if @report.update_attributes(params[:report])
        format.html { redirect_to(@report, :notice => 'Report was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @report.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.xml
  def destroy
    @report.destroy

    respond_to do |format|
      format.html { redirect_to(reports_url) }
      format.xml  { head :ok }
    end
  end

  def data
    @report = Report.find(params[:id])

    dashboard = (params[:dashboard_id].present? ? Dashboard.find(params[:dashboard_id]) : nil)
    if dashboard
      dashboard_report = DashboardReport.where(:report_id => @report.id, :dashboard_id => dashboard.id).first
      filter_prefs = dashboard_report.filter_prefs
      filter_set = dashboard.filter_set
    else
      filter_prefs = nil
      filter_set = nil
    end
    respond_to do |format|
      format.json { render :json => @report.json_data({}, filter_prefs, filter_set) }
    end
  end

end
