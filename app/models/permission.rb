class Permission < ActiveRecord::Base
  has_and_belongs_to_many :roles
  
  # NOTE: the numbers of the abilities must not change, see seeds.rb
  VIEW_ANALYTICS_AND_RUN_REPORTS = Permission.find_by_ability(1)
  CREATE_REPORTS = Permission.find_by_ability(2)
  MANAGE_USERS = Permission.find_by_ability(3)
  MANAGE_ROLES = Permission.find_by_ability(4)
  CONFIGURATION = Permission.find_by_ability(5)

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end
