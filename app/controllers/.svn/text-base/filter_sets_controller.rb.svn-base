class FilterSetsController < ApplicationController
  load_and_authorize_resource

  include ComboTable
  helper_method :sort_column, :sort_direction
  combo_table :filter_set, :columns => [:name, :description],
              :actions => [:edit, :destroy],
              :klass_display_name => 'Data Segment'

  set_tab :analytics
  set_tab :data_segments, :sub_nav
  before_filter do
    @sub_nav_group = :analytics
  end

  # let ComboTable handle rendering
  ## GET /filter_sets
  ## GET /filter_sets.xml
  #def index
  #  respond_to do |format|
  #    format.html # index.html.erb
  #    format.xml  { render :xml => @filter_sets }
  #  end
  #end

  # GET /filter_sets/1
  # GET /filter_sets/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @filter_set }
    end
  end

  # GET /filter_sets/new
  # GET /filter_sets/new.xml
  def new
    FilterParam.where(:enable_for_filter_sets => true).each do |filter_param|
      filter_param_association = @filter_set.filter_param_associations.build(:filter_param_id => filter_param.id)
      filter_pref = filter_param_association.filter_prefs.build
      filter_pref.filter_param_association = filter_param_association
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @filter_set }
    end
  end

  # GET /filter_sets/1/edit
  def edit
    FilterParam.where(:enable_for_filter_sets => true).each do |filter_param|
      if @filter_set.filter_prefs.select{
          |filter_pref| filter_pref.filter_param == filter_param
      }.blank?
        filter_param_association = @filter_set.filter_param_associations.build(:filter_param_id => filter_param.id)
        filter_pref = filter_param_association.filter_prefs.build
        filter_pref.filter_param_association = filter_param_association
      end
    end
  end

  # POST /filter_sets
  # POST /filter_sets.xml
  def create
    respond_to do |format|
      if @filter_set.save
        format.html { redirect_to(filter_sets_path, :notice => 'Filter set was successfully created.') }
        format.xml  { render :xml => @filter_set, :status => :created, :location => @filter_set }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @filter_set.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /filter_sets/1
  # PUT /filter_sets/1.xml
  def update
    respond_to do |format|
      if @filter_set.update_attributes(params[:filter_set])
        format.html { redirect_to(filter_sets_path, :notice => 'Filter set was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @filter_set.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /filter_sets/1
  # DELETE /filter_sets/1.xml
  def destroy
    @filter_set.destroy

    respond_to do |format|
      format.html { redirect_to(filter_sets_url) }
      format.xml  { head :ok }
    end
  end
end
