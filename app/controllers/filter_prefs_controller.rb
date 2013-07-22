class FilterPrefsController < ApplicationController
  # GET /filter_prefs
  # GET /filter_prefs.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @filter_prefs }
    end
  end

  # GET /filter_prefs/1
  # GET /filter_prefs/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @filter_pref }
    end
  end

  # GET /filter_prefs/new
  # GET /filter_prefs/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @filter_pref }
    end
  end

  # GET /filter_prefs/1/edit
  def edit
  end

  # POST /filter_prefs
  # POST /filter_prefs.xml
  def create
    respond_to do |format|
      if @filter_pref.save
        format.html { redirect_to(@filter_pref, :notice => 'Filter pref was successfully created.') }
        format.xml  { render :xml => @filter_pref, :status => :created, :location => @filter_pref }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @filter_pref.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /filter_prefs/1
  # PUT /filter_prefs/1.xml
  def update
    respond_to do |format|
      if @filter_pref.update_attributes(params[:filter_pref])
        format.html { redirect_to(@filter_pref, :notice => 'Filter pref was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @filter_pref.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /filter_prefs/1
  # DELETE /filter_prefs/1.xml
  def destroy
    @filter_pref.destroy

    respond_to do |format|
      format.html { redirect_to(filter_prefs_url) }
      format.xml  { head :ok }
    end
  end
end
