class DashboardsController < ApplicationController

  load_and_authorize_resource

  include DashboardsHelper

  include ComboTable
  helper_method :sort_column, :sort_direction
  combo_table :dashboard, :columns => [:name, :reports_names, :owner_name]
  
  set_tab :analytics
  set_tab :dashboard, :sub_nav
  before_filter do
    @sub_nav_group = :analytics
  end

  # GET /dashboards/1
  # GET /dashboards/1.xml
  def show
    # TODO limit to 5 tabs
    if @dashboard
      @dashboards = current_user.owned_dashboards
      set_tab "dashboard_#{@dashboard.id}".to_sym, :sub_nav_2
    else
      @dashboards = [@dashboard]
    end
    @reports = nil
    if @dashboard
      @displayed_reports = @dashboard.reports
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @dashboard }
    end
  end

  # GET /dashboards/new
  # GET /dashboards/new.xml
  def new
    respond_to do |format|
      if @dashboard.original_id
        original_dashboard = Dashboard.find(@dashboard.original_id)
        @dashboard = original_dashboard.clone
        @dashboard.original_id = original_dashboard.id
        @dashboard.shared = false
#        @dashboard.name = "#{original_dashboard.name} copy"
        @dashboard.owner = current_user
        format.html
      else
        @readable_dashboards = readable_dashboards_for_collection
        @dashboard.original_id = @readable_dashboards.try(:first).try(:first)
        format.html { render 'select' }
      end
      format.xml  { render :xml => @dashboard }
    end
  end

  # GET /dashboards/1/edit
  def edit
    respond_to do |format|
      format.html # edit.html.erb
      format.xml  { render :xml => @dashboard }
    end
  end

  # POST /dashboards
  # POST /dashboards.xml
  def create
    original_dashboard = Dashboard.find(@dashboard.original_id)
    @dashboard.subscribers = [current_user]
    @dashboard.owner = current_user
    @dashboard.dashboard_reports = original_dashboard.dashboard_reports.collect { |dr| dr.clone }

    respond_to do |format|
      if @dashboard.save
        format.html { redirect_to(@dashboard, :notice => 'Dashboard was successfully created.') }
        format.xml  { render :xml => @dashboard, :status => :created, :location => @dashboard }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @dashboard.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /dashboards/1
  # PUT /dashboards/1.xml
  def update
    respond_to do |format|
      if @dashboard.update_attributes(params[:dashboard])
        format.html { redirect_to(@dashboard, :notice => 'Dashboard was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @dashboard.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /dashboards/1
  # DELETE /dashboards/1.xml
  def destroy
    @dashboard.destroy

    respond_to do |format|
      format.html { redirect_to(default_dashboard_path) }
      format.xml  { head :ok }
    end
  end
end
