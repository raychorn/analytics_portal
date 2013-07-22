class UserDashboard < ActiveRecord::Base
  belongs_to :user
  belongs_to :dashboard
end
