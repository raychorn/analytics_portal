class RolesController < ApplicationController

  load_and_authorize_resource

  include ComboTable
  helper_method :sort_column, :sort_direction
  combo_table :role, :columns => [[:name, 'Name'], [:permissions_names, 'Permissions']],
              :actions => [:new, :edit, :destroy]

  set_tab :roles
  set_tab :roles, :sub_nav
  before_filter do
    @sub_nav_group = :roles
  end

#  def show
#    @role = Role.find(params[:id])
#
#    respond_to do |format|
#      format.html { render '_show' }
#      format.xml  { render :xml => @role }
#    end
#  end

  def new
    respond_to do |format|
      format.html { render '_new' }
      format.xml  { render :xml => @role }
    end
  end
  
  def edit
    respond_to do |format|
      format.html { render '_edit' }
      format.xml  { render :xml => @role }
    end
  end

  def create
    respond_to do |format|
      if @role.save
        format.html { redirect_to(roles_path, :notice => 'Role was successfully created.') }
        format.xml  { render :xml => @role, :status => :created, :location => @role }
      else
        format.html { render '_new' }
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @role.update_attributes(params[:role])
        format.html { redirect_to(roles_path, :notice => 'Role was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render '_edit' }
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end
end
