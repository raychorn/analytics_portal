class ReportLinksController < ApplicationController

  load_and_authorize_resource

  # GET /report_links
  # GET /report_links.xml
  def index
    @report_links = ReportLink.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @report_links }
    end
  end

  # GET /report_links/1
  # GET /report_links/1.xml
  def show
    @report_link = ReportLink.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @report_link }
    end
  end

  # GET /report_links/new
  # GET /report_links/new.xml
  def new
    @report_link = ReportLink.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @report_link }
    end
  end

  # GET /report_links/1/edit
  def edit
    @report_link = ReportLink.find(params[:id])
  end

  # POST /report_links
  # POST /report_links.xml
  def create
    @report_link = ReportLink.new(params[:report_link])

    respond_to do |format|
      if @report_link.save
        format.html { redirect_to(@report_link, :notice => 'Report link was successfully created.') }
        format.xml  { render :xml => @report_link, :status => :created, :location => @report_link }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @report_link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /report_links/1
  # PUT /report_links/1.xml
  def update
    @report_link = ReportLink.find(params[:id])

    respond_to do |format|
      if @report_link.update_attributes(params[:report_link])
        format.html { redirect_to(@report_link, :notice => 'Report link was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @report_link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /report_links/1
  # DELETE /report_links/1.xml
  def destroy
    @report_link = ReportLink.find(params[:id])
    @report_link.destroy

    respond_to do |format|
      format.html { redirect_to(report_links_url) }
      format.xml  { head :ok }
    end
  end
end
