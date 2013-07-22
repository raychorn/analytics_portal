require 'active_support/core_ext/class/attribute'
require 'active_resource/exceptions'

module ComboTable
  extend ActiveSupport::Concern

  # initialize attributes that need to be persisted in the calling class
  included do
    class_attribute :klass_columns, :klass_actions, :hide_action, :column_pairs, :klass_display_name
    self.klass_columns ||= []
    self.klass_actions ||= nil
    self.hide_action ||= false
    self.klass_display_name ||= nil
  end

  # add class and instance methods to calling class
  def self.included(base)
    base.extend ClassMethods    
  end
  
  module ClassMethods

    # sets up parameters
    def combo_table(klass_sym, params = {})
      columns = params[:columns]
      self.column_pairs = (columns.first.respond_to?(:each) ? columns : columns.collect { |col| [col, col.to_s.titleize] })
      self.klass_actions = params[:actions]
      klass_name = klass_sym.to_s.camelize
      klass_sym_str = ":#{klass_sym.to_s}"
      klass_variable = klass_sym.to_s
      self.klass_columns = columns
      self.hide_action = params[:hide_action]
      self.klass_display_name = params[:klass_display_name]
      self.klass_display_name ||= klass_sym.to_s.humanize.titleize

      class_eval <<-EOC
        # GET /objects
        # GET /objects.xml
        def index
          begin
            @objects = instance_variable_get("@#{klass_variable.pluralize}")
            @objects = @objects.search(params[:search]).order(sort_column(#{klass_name}) + ' ' + sort_direction).
              paginate(:per_page => 20, :page => params[:page])
          rescue ActiveResource::ServerError
            instance_variable_set("@#{klass_variable.pluralize}", [])
            @objects = instance_variable_get("@#{klass_variable.pluralize}")
            flash[:alert] = "The data source appears to be down or unresponsive.  Contact your administrator."
          end
          respond_to do |format|
            format.html { render 'combo_table/_index', :locals => {
              :objects => @objects, :object_sym => #{klass_sym_str}, :columns => self.klass_columns,
              :actions => self.klass_actions, :hide_action => self.hide_action,
              :klass_display_name => self.klass_display_name }
            }
            format.xml  { render :xml => @objects }
          end
        end
      
        # GET /objects/1
        # GET /objects/1.xml
        def show
          @object = instance_variable_get("@#{klass_variable}")
      
          respond_to do |format|
            format.html { render 'combo_table/_show', :locals => {
              :object => @object, :object_sym => #{klass_sym_str}, :columns => self.klass_columns } }
            format.xml  { render :xml => @object }
          end
        end
      
        # GET /objects/new
        # GET /objects/new.xml
        def new
          @object =  #{klass_name}.new
      
          respond_to do |format|
            format.html { render 'combo_table/_new', :locals => {
              :object => @object, :object_sym => #{klass_sym_str}, :columns => self.klass_columns } }
            format.xml  { render :xml => @object }
          end
        end
      
        # GET /objects/1/edit
        def edit
          @object = instance_variable_get("@#{klass_variable}")
          
          respond_to do |format|
            format.html { render 'combo_table/_edit', :locals => {
              :object => @object, :object_sym => #{klass_sym_str}, :columns => self.klass_columns } }
            format.xml  { render :xml => @object }
          end
        end
      
        # POST /objects
        # POST /objects.xml
        def create
          @object =  #{klass_name}.new(params[#{klass_sym_str}])
      
          respond_to do |format|
            if @object.save
              format.html { redirect_to(@object, :notice => "#{klass_name} was successfully created.") }
              format.xml  { render :xml => @object, :status => :created, :location => @object }
            else
              format.html { render 'combo_table/_new', :locals => {
                :object => @object, :object_sym => #{klass_sym_str}, :columns => self.klass_columns } }
              format.xml  { render :xml => @object.errors, :status => :unprocessable_entity }
            end
          end
        end
      
        # PUT /objects/1
        # PUT /objects/1.xml
        def update
          @object = instance_variable_get("@#{klass_variable}")
      
          respond_to do |format|
            if @object.update_attributes(params[#{klass_sym_str}])
              format.html { redirect_to(@object, :notice => "#{klass_name} was successfully updated.") }
              format.xml  { head :ok }
            else
              format.html { render 'combo_table/_edit', :locals => {
                :object => @object, :object_sym => #{klass_sym_str}, :columns => self.klass_columns } }
              format.xml  { render :xml => @object.errors, :status => :unprocessable_entity }
            end
          end
        end
      
        # DELETE /objects/1
        # DELETE /objects/1.xml
        def destroy
          @object = instance_variable_get("@#{klass_variable}")
          @object.destroy
      
          respond_to do |format|
            format.html { redirect_to(url_to(#{klass_sym_str})) }
            format.xml  { head :ok }
          end
        end      
      EOC

    end # combo_table

  end # ClassModule
  
private
  
  # TODO: handle exceptions
  def sort_column(sort_sym)
    sort_sym.to_s.camelize.constantize.column_names.include?(params[:sort]) ? params[:sort] : self.column_pairs.first.first.to_s
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end