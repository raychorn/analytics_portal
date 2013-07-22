class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  # disabled: :registerable
  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_dashboards, :dependent => :destroy
  has_many :subscribed_dashboards, :through => :user_dashboards, :source => :dashboard
  has_many :owned_dashboards, :foreign_key => :owner_id, :class_name => 'Dashboard', :order => 'position'
  has_many :filter_prefs, :dependent => :destroy
  has_and_belongs_to_many :roles

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me, :role_ids

  validates_presence_of :first_name, :last_name, :email

  def name
    "#{first_name} #{last_name}"
  end

  def add_role(role)
    roles << role unless roles.exists?(role.id)
  end

  def remove_role(role)
    roles.delete(role)
  end

  def has_role?(role)
    roles.exists?(role.id)
  end

  def roles_names
    roles.collect{ |r| r.name }.join ', '
  end

  def has_permission?(permission)
    permissions = roles.collect{ |r| r.permissions }.flatten
    !permissions.index(permission).nil?
  end

  # for dashboard sort order dropdown
  def dashboard_positions_collection
    (1..(self.owned_dashboards.count + 1)).collect do |i|
      [i, i.ordinalize]
    end
  end
  
  def self.search(search)
    if search
      where('email LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end
