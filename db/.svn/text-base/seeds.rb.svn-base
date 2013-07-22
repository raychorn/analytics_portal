# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# create or update permissions
[[1, "View Analytics and Run Reports", ""],
 [2, "Create Reports", ""], 
 [3, "Manage Users", ""],
 [4, "Manager Roles", ""],
 [5, "Configuration", ""]].each do |p_array|  
  permission = Permission.find_by_ability(p_array[0]) 
  permission ||= Permission.new
  permission.attributes = {
    :ability => p_array[0],
    :name => p_array[1],
    :description => p_array[2]
  }
  permission.save!
end

# create or update root user
root_user_email = 'root@analytics.local'
root_user = User.find_by_email(root_user_email)
root_user ||= User.new
root_user.attributes = {
  :email => root_user_email,
  :password => 'analytics',
  :password_confirmation => 'analytics',
  :first_name => 'root',
  :last_name => 'user'
  # TODO - Fred - set deletable flag to false for this user
  # :deletable => false
}
root_user.global_admin = true
root_user.save!

# create "administrator" role
admin_role_name = 'administrator'
admin_role = Role.find_by_name(admin_role_name)
admin_role ||= Role.new
admin_role.attributes = {
  :name => admin_role_name
}
admin_role.permissions = Permission.all
admin_role.save!

# create or update admin user
admin_user_email = 'admin@analytics.local'
admin_user = User.find_by_email(admin_user_email)
admin_user ||= User.new
admin_user.attributes = {
  :email => admin_user_email,
  :password => 'analytics', 
  :password_confirmation => 'analytics',
  :first_name => 'admin',
  :last_name => 'user'
}
admin_user.add_role(admin_role)
admin_user.save!

all_customers_filter_set = FilterSet.where(:id => 1).first
all_customers_filter_set ||= FilterSet.new
all_customers_filter_set.attributes = {
    :name => 'All Customers',
    :description => 'all reported customer data'
}
all_customers_filter_set.id = 1
all_customers_filter_set.save!

default_dashboard = Dashboard.where(:id => 1).first
default_dashboard ||= Dashboard.new
default_dashboard.attributes = {
    :name => 'My Dashboard',
    :owner_id => admin_user.id,
    :shared => true,
    :position => 1,
    :filter_set_id => all_customers_filter_set.id
}
default_dashboard.id = 1
default_dashboard.save!

configuration = Configuration.instance
configuration.attributes = {
  :default_dashboard => default_dashboard
}
configuration.save!
