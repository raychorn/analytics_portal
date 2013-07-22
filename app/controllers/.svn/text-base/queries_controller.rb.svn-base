class QueriesController < ApplicationController

  load_and_authorize_resource

  include ComboTable
  helper_method :sort_column, :sort_direction
  combo_table :query, :columns => [:query_string, :data_segment_name, :store_in_db, :query_result_id]

  # GET /queries/1
  # GET /queries/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @query }
    end
  end

  # GET /queries/new
  # GET /queries/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @query }
    end
  end

  # GET /queries/1/edit
  def edit
  end

  # POST /queries
  # POST /queries.xml
  def create
    respond_to do |format|
      if @query.save
        format.html { redirect_to(@query, :notice => 'Query was successfully created.') }
        format.xml  { render :xml => @query, :status => :created, :location => @query }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @query.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /queries/1
  # PUT /queries/1.xml
  def update
    respond_to do |format|
      if @query.update_attributes(params[:query])
        format.html { redirect_to(@query, :notice => 'Query was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @query.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /queries/1
  # DELETE /queries/1.xml
  def destroy
    @query.destroy

    respond_to do |format|
      format.html { redirect_to(queries_url) }
      format.xml  { head :ok }
    end
  end
end
