class DataSegmentsController < ApplicationController

  load_and_authorize_resource

  include ComboTable
  helper_method :sort_column, :sort_direction
  combo_table :data_segment,
              :columns => [[:name, 'Name'], [:description, 'Description'], [:job_runners_status, 'Status'],
                           [:schedule, 'Schedule']],
              :actions => [:show, :edit, :destroy, :start] ,
              :klass_display_name => 'Job'

  set_tab :analytics
  set_tab :jobs, :sub_nav
  before_filter do
    @sub_nav_group = :analytics
  end

  # # GET /data_segments
  # # GET /data_segments.xml
  # def index
  #   @data_segments = DataSegment.all
  #
  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.xml  { render :xml => @data_segments }
  #   end
  # end

  # GET /data_segments/1
  # GET /data_segments/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @data_segment }
    end
  end

  # GET /data_segments/new
  # GET /data_segments/new.xml
  def new
    @data_segment.data_source = DataSource.first
    @data_segment.queries.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @data_segment }
    end
  end

  # GET /data_segments/1/edit
  def edit
  end

  # POST /data_segments
  # POST /data_segments.xml
  def create
    respond_to do |format|
      if @data_segment.save!
        @data_segment.setup_job_runners
        @data_segment.enable_schedule? ? @data_segment.send_enable_schedule : @data_segment.send_disable_schedule
        format.html { redirect_to(@data_segment, :notice => 'Data segment was successfully created.') }
        format.xml  { render :xml => @data_segment, :status => :created, :location => @data_segment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @data_segment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /data_segments/1
  # PUT /data_segments/1.xml
  def update
    respond_to do |format|
      if @data_segment.update_attributes!(params[:data_segment])
        @data_segment.setup_job_runners
        @data_segment.enable_schedule? ? @data_segment.send_enable_schedule : @data_segment.send_disable_schedule
        format.html { redirect_to(@data_segment, :notice => 'Data segment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @data_segment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /data_segments/1
  # DELETE /data_segments/1.xml
  def destroy
    @data_segment.destroy

    respond_to do |format|
      format.html { redirect_to(data_segments_url) }
      format.xml  { head :ok }
    end
  end

  def start
    @data_segment.start_job_runners

    respond_to do |format|
      format.html { redirect_to(data_segments_url) }
      format.xml  { render :xml => @data_segment }
    end
  end
end
