class FilterParamAssociation < ActiveRecord::Base
  belongs_to :filter_param
  belongs_to :optionable, :polymorphic => true
  has_many :filter_prefs, :dependent => :destroy

  accepts_nested_attributes_for :filter_prefs
end
