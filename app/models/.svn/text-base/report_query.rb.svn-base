class ReportQuery < ActiveRecord::Base
  belongs_to :report
  belongs_to :query

  has_many :filter_params, :dependent => :destroy

  validates :chart_params, :json_or_blank => true
  # TODO enable validation after sample data is no longer needed
#  validates :y_column, :presence => true

  def name
    self.query.try(:name)
  end
end
