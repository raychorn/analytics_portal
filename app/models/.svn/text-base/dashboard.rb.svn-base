class Dashboard < ActiveRecord::Base
  has_many :user_dashboards, :dependent => :destroy
  # subscribers is not currently used
  has_many :subscribers, :through => :user_dashboards, :source => :user
  has_many :dashboard_reports, :dependent => :destroy
  has_many :reports, :through => :dashboard_reports
  belongs_to :owner, :class_name => 'User'
  belongs_to :filter_set

  attr_accessible :name, :owner_id, :report_ids, :subscriber_ids, :dashboard_reports_attributes, :filter_prefs,
                  :shared, :original_id, :move_to_position, :filter_set_id

  accepts_nested_attributes_for :dashboard_reports, :allow_destroy => true

  attr_accessor :original_id

  validates :name, :presence => true
  validates :filter_prefs, :json_or_blank => true
  validates :filter_set_id, :presence => true

  acts_as_list :scope => :owner

  def owner_name
    owner ? owner.name : nil
  end

  def reports_names
    reports.collect{ |r| r.name }.join ', '
  end

  def filter_prefs_hash
    filter_prefs.present? ? JSON.parse(filter_prefs) : {}
  end

  def move_to_position
    self.position
  end

  def move_to_position=(pos)
    self.insert_at(pos)
  end

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end
