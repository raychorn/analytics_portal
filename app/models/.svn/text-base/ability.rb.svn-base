class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities

    # TODO - Fred - restrict deletable root and admin user
    #    cannot :destroy, User, :deletable => false
    #    add migration for adding 'deletable' column to users table

    user ||= User.new # guest user (not logged in)
    if user.has_permission? Permission::VIEW_ANALYTICS_AND_RUN_REPORTS
      can :manage, Dashboard, :owner_id => user.id
      can :read, Dashboard, :shared => true
      can :manage, DashboardReport, :dashboard => { :owner_id => user.id }
      can :read, Report
      can :data, Report
    end
    if user.has_permission? Permission::CREATE_REPORTS
      can :manage, Report
      can :manage, DataSegment
      cannot :show, DataSegment
      cannot :create, DataSegment
      cannot :destroy, DataSegment
      can :manage, FilterSet
      can :manage, Query
    end
    if user.has_permission? Permission::MANAGE_USERS
      can :manage, User
      cannot :show, User
    end
    if user.has_permission? Permission::MANAGE_ROLES
      can :manage, Role
    end
    if user.has_permission? Permission::CONFIGURATION
      can :manage, Configuration
    end
    if user.global_admin?
      can :manage, :all
    end

  end
end
