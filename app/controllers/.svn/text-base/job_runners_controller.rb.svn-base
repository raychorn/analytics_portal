class JobRunnersController < ApplicationController

  load_and_authorize_resource :except => [:index]

  # GET /job_runners
  # GET /job_runners.xml
  def index
    begin
      @job_runners = JobRunner.accessible_by(current_ability)
    rescue ActiveResource::ServerError
      @job_runners = []
      flash[:alert] = "The data source appears to be down or unresponsive.  Contact your system administrator."
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @job_runners }
    end
  end

  # GET /job_runners/1
  # GET /job_runners/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @job_runner }
    end
  end

  # GET /job_runners/new
  # GET /job_runners/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @job_runner }
    end
  end

  # GET /job_runners/1/edit
  def edit
  end

  # POST /job_runners
  # POST /job_runners.xml
  def create
    respond_to do |format|
      if @job_runner.save
        format.html { redirect_to(@job_runner, :notice => 'Job runner was successfully created.') }
        format.xml  { render :xml => @job_runner, :status => :created, :location => @job_runner }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @job_runner.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /job_runners/1
  # PUT /job_runners/1.xml
  def update
    respond_to do |format|
      if @job_runner.update_attributes(params[:job_runner])
        format.html { redirect_to(@job_runner, :notice => 'Job runner was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @job_runner.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /job_runners/1
  # DELETE /job_runners/1.xml
  def destroy
    @job_runner.destroy

    respond_to do |format|
      format.html { redirect_to(job_runners_url) }
      format.xml  { head :ok }
    end
  end

  def start
    @job_runner.start

    respond_to do |format|
      format.html { redirect_to(job_runners_url) }
      format.xml  { render :xml => @job_runner }
    end
  end
end
