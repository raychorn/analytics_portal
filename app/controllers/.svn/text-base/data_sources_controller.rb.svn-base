class DataSourcesController < ApplicationController

  load_and_authorize_resource

  include ComboTable
  helper_method :sort_column, :sort_direction
  combo_table :data_source, :columns => [:name, :url, :database_name]

  set_tab :analytics
  set_tab :data_sources, :sub_nav
  before_filter do
    @sub_nav_group = :analytics
  end
  
  # # GET /data_sources
  # # GET /data_sources.xml
  # def index
  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.xml  { render :xml => @data_sources }
  #   end
  # end

  # GET /data_sources/1
  # GET /data_sources/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @data_source }
    end
  end

  # GET /data_sources/new
  # GET /data_sources/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @data_source }
    end
  end

  # GET /data_sources/1/edit
  def edit
  end

  # POST /data_sources
  # POST /data_sources.xml
  def create
    respond_to do |format|
      if @data_source.save
        format.html { redirect_to(data_sources_path, :notice => 'Data source was successfully created.') }
        format.xml  { render :xml => @data_source, :status => :created, :location => @data_source }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @data_source.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /data_sources/1
  # PUT /data_sources/1.xml
  def update
    respond_to do |format|
      if @data_source.update_attributes(params[:data_source])
        format.html { redirect_to(data_sources_path, :notice => 'Data source was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @data_source.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /data_sources/1
  # DELETE /data_sources/1.xml
  def destroy
    @data_source.destroy

    respond_to do |format|
      format.html { redirect_to(data_sources_url) }
      format.xml  { head :ok }
    end
  end
end
