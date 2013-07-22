class FilterSet < ActiveRecord::Base
  has_many :filter_param_associations, :as => :optionable, :dependent => :destroy
  has_many :filter_prefs, :through => :filter_param_associations, :dependent => :destroy
  has_many :filter_params, :through => :filter_param_associations

  accepts_nested_attributes_for :filter_prefs, :allow_destroy => true
  accepts_nested_attributes_for :filter_param_associations, :allow_destroy => true

  attr_accessible :name, :description, :region, :filter_prefs_attributes, :filter_param_associations_attributes

  validates_presence_of :name

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end
