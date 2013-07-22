class DashboardReport < ActiveRecord::Base
  belongs_to :dashboard
  belongs_to :report

  has_many :filter_prefs, :as => :optionable, :dependent => :destroy

  accepts_nested_attributes_for :filter_prefs, :allow_destroy => true

  validates_numericality_of :position, :greater_than => 0
    
  class Size

    attr_reader :name, :id

    def self.all
      SIZES
    end

  private
    attr_writer :name, :id

    SIZES = ['small', 'medium', 'large']
  end
end
