class Report < ActiveRecord::Base
  has_many :dashboard_reports, :dependent => :destroy
  has_many :report_queries, :dependent => :destroy
  has_many :dashboards, :through => :dashboard_reports
  has_many :queries, :through => :report_queries
  has_many :filter_param_associations, :as => :optionable, :dependent => :destroy
  has_many :filter_params, :through => :filter_param_associations
  has_many :filter_prefs, :as => :optionable, :dependent => :destroy
  has_many :report_links, :dependent => :destroy
  belongs_to :filter_set

  accepts_nested_attributes_for :report_queries, :allow_destroy => true
  accepts_nested_attributes_for :filter_param_associations, :allow_destroy => true
  accepts_nested_attributes_for :filter_params, :allow_destroy => true
  accepts_nested_attributes_for :filter_prefs, :allow_destroy => true
  accepts_nested_attributes_for :report_links, :allow_destroy => true

  attr_accessor :series_data, :report_type

  # TODO define
  #attr_accessible :filter_set_id ...

  acts_as_taggable

  validates :name, :presence => true
  validates :filter_set_id, :presence => true

  # for single table inheritance controller
  def self.inherited(child)
    child.instance_eval do
      def model_name
        Report.model_name
      end
    end
    super
  end

  # for single table inheritance controller
  def self.report_subclasses
    descendants
  end

  # for single table inheritance controller
  def self.report_subclasses_strings
    report_subclasses.collect { |c| c.to_s }.sort
  end

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

private ###############################

  def selected_report_queries(filter_prefs)
    filter_param_with_groups = self.filter_params.select { |fp| fp.filter_param_type == 'query_select' }
    query_filter_groups = filter_param_with_groups.collect { |fp| JSON.parse(fp.column) }.flatten.uniq
    valid_report_queries = self.report_queries.select do |report_query|
      if report_query.query.blank?
        false
      elsif query_filter_groups.include?(report_query.query_select_group)
        # need to see what groups are enabled
        enabled_filters = filter_prefs.select { |pref| pref.selected.present? }
        enabled_groups = enabled_filters.collect { |pref| pref.selected }
        # in Ruby 1.8 this is an array, in Ruby 1.9 it's a hash
        enabled_groups.blank? || enabled_groups.include?(report_query.query_select_group)
      else
        true
      end
    end
    valid_report_queries
  end

  # params can be either :filter_param or :report_query
  def series_data_array(data, params = {})
    if data.blank?
      return []
    end

    params ||= {}
    filter_param = params[:filter_param]
    report_query = params[:report_query]
    if filter_param.present?
      x_col = filter_param.date_column
      y_col = filter_param.column
      name_col = nil
      radius_col = nil
    elsif report_query.present?
      x_col = report_query.x_column
      y_col = report_query.y_column
      name_col = report_query.name_column
      radius_col = report_query.radius_column
    else
      raise ':filter_param or :report_query required'
    end

    columns = data.result_set.column_names_array
#    raise 'columns must not be blank' if columns.blank?
    logger.error '[ERROR] columns must not be blank' if columns.blank?

    # construct the series data for highcharts
    result_set = data.result_set
    if radius_col.present? && x_col.present? && y_col.present?
      series_data = result_set.results_array.collect { |row|
        {
            :x => self.class.check_and_convert_to_utc_ms(x_col, result_set.value_at(row, x_col)),
            :y => self.class.check_and_convert_to_utc_ms(y_col, result_set.value_at(row, y_col)),
            :marker => {:radius => result_set.value_at(row, radius_col)},
            :name => result_set.value_at(row, name_col)
        }
      }
    elsif x_col.blank? && y_col.present?
      series_data = result_set.results_array.collect { |row|
        self.class.check_and_convert_to_utc_ms(y_col, result_set.value_at(row, y_col))
      }
    elsif x_col.present? && y_col.present?
      series_data = result_set.results_array.collect { |row|
        [
            self.class.check_and_convert_to_utc_ms(x_col, result_set.value_at(row, x_col)),
            self.class.check_and_convert_to_utc_ms(y_col, result_set.value_at(row, y_col))
        ]
      }
    else
      raise "incorrect series data columns specified: #{x_col}, #{y_col}, #{radius_col}, #{radius_col}"
    end
    return series_data
  end

  def self.check_and_convert_to_utc_ms(date_col, val)
    if val.is_a?(Time)
      val.to_i * 1000
    elsif (date_col.eql? "date_by_day") || (date_col.eql? "c_date")
      DateTime.strptime(val, '%Y-%m-%d').to_i * 1000
    elsif (date_col.eql? "date_by_month") || (date_col.eql? "server_date")
      DateTime.strptime(val, '%Y-%m').to_i * 1000
    elsif date_col.eql? "date_by_hour"
      DateTime.strptime(val, '%Y-%m-%d %H').to_i * 1000
    elsif date_col.eql? "hour"
      val.to_i * 3600000
    else
      # TODO improve type preservation as this is a hack
      begin
        Integer(val)
      rescue
        begin
          Float(val)
        rescue
          val
        end
      end
    end
  end
end
