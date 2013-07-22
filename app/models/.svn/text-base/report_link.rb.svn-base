class ReportLink < ActiveRecord::Base
  belongs_to :report
  belongs_to :linked_report, :class_name => 'Report'

  attr_accessible :name, :filter_columns, :linked_report_id

  validates_presence_of :name
  validates_presence_of :linked_report_id
  validates_presence_of :report_id
end
