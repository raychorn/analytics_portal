class ReportQueriesController < ApplicationController

  load_and_authorize_resource

  include ComboTable
  helper_method :sort_column, :sort_direction
  combo_table :report_query, :columns => [:report_id, :query_id, :query_string]

  # GET /report_queries
  # GET /report_queries.xml
  def index
    @report_queries = ReportQuery.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @report_queries }
    end
  end

  # GET /report_queries/1
  # GET /report_queries/1.xml
  def show
    @report_query = ReportQuery.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @report_query }
    end
  end

  # GET /report_queries/new
  # GET /report_queries/new.xml
  def new
    @report_query = ReportQuery.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @report_query }
    end
  end

  # GET /report_queries/1/edit
  def edit
    @report_query = ReportQuery.find(params[:id])
  end

  # POST /report_queries
  # POST /report_queries.xml
  def create
    @report_query = ReportQuery.new(params[:report_query])

    respond_to do |format|
      if @report_query.save
        format.html { redirect_to(@report_query, :notice => 'Report query was successfully created.') }
        format.xml  { render :xml => @report_query, :status => :created, :location => @report_query }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @report_query.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /report_queries/1
  # PUT /report_queries/1.xml
  def update
    @report_query = ReportQuery.find(params[:id])

    respond_to do |format|
      if @report_query.update_attributes(params[:report_query])
        format.html { redirect_to(@report_query, :notice => 'Report query was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @report_query.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /report_queries/1
  # DELETE /report_queries/1.xml
  def destroy
    @report_query = ReportQuery.find(params[:id])
    @report_query.destroy

    respond_to do |format|
      format.html { redirect_to(report_queries_url) }
      format.xml  { head :ok }
    end
  end
end
