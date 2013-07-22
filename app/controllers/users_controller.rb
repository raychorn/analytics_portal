class UsersController < ApplicationController

  load_and_authorize_resource

  include ComboTable
  helper_method :sort_column, :sort_direction
  combo_table :user, :columns => [[:first_name, 'First Name'], [:last_name, 'Last Name'],
                                  [:email, 'Email'], [:roles_names, 'Roles']]

  set_tab :users
  set_tab :users, :sub_nav
  before_filter do
    @sub_nav_group = :users
  end

  def new
    respond_to do |format|
      format.html { render '_new' }
      format.xml  { render :xml => @user }
    end
  end

  def edit
    respond_to do |format|
      format.html { render '_edit' }
      format.xml  { render :xml => @user }
    end
  end
  
  def show
    if params[:id].present?
      @user = User.find(params[:id])
      heading = "#{@user.name}'s Account"
    else
      @user = current_user
      heading = "My Account"
    end

    respond_to do |format|
      format.html { render 'combo_table/_show', :locals => { 
        :object => @user, :object_sym => :user, :columns => [:name, :email, :password, :roles_names], 
        :heading => heading, :object_name => 'account'
      } }
      format.xml  { render :xml => @object }
    end
  end

  # only an admin can create users, which means the password will not be set
  def create
    @user.password = 'P@ssw0rd'
    @user.password_confirmation = 'P@ssw0rd'

    if @user.valid?
      valid_user = true
      # clear out the password
      @user.password = nil
      @user.password_confirmation = nil
    else
      valid_user = false
    end

    respond_to do |format|
      # send invitation email
      if valid_user && @user.invite!
        format.html { redirect_to(users_path, :notice => "User invitation was successfully sent.") }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render '_new' }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(users_path, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render '_edit' }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

end
