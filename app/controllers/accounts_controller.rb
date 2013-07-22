class AccountsController < ApplicationController

  skip_authorization_check

  set_tab :users
  set_tab :account, :sub_nav
  before_filter do
    @sub_nav_group = :account
  end

  # GET /data_segments/1/edit
  def edit
    @user = current_user
    respond_to do |format|
      format.html { render 'edit' }
      format.xml  { render :xml => @user }
    end
  end
  
  def show
    @user = current_user
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def update
    @user = current_user
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(account_path, :notice => 'Account successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render 'edit' }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

end
