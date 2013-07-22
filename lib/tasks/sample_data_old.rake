require_dependency "#{Rails.root}/db/seed_data_helper.rb"
require 'json'

namespace :app do
  desc <<-DESC
    Load sample data.
    Run using the command 'rake app:sample_data'
  DESC
  task :sample_data_old => [:environment] do
    # Only data not required in production should be here.
    # If it needs to be there in production, it belongs in seeds.rb.

    fixtures_path = "#{Rails.root}/test/fixtures"

    # Data Sources #######################################

    data_source_fields = [:name, :url, :database_name]
    data_source_seeds =
        {
            :localhost => ['localhost', 'http://localhost:3001', 'bakrie']
        }
    data_sources = SeedDataHelper.create_or_update_objects(DataSource, data_source_fields, data_source_seeds)

    # Data Segments #######################################

    data_segment_fields = [:name, :data_source_id, :properties]
    data_segment_seeds =
        {
            :error_scatterplot => [
                'Error Scatterplot', data_sources[:localhost].id,
                nil
            ],
            :data_by_technology => [
                'Data by Technology', data_sources[:localhost].id,
                File.open("#{fixtures_path}/data_segment/data_by_technology_properties.json").read
            ],
            :licensing_report => [
                'Licensing Report', data_sources[:localhost].id,
                nil
            ],
            :usage_trend => [
                'Usage Trend', data_sources[:localhost].id,
                nil
            ],
            :device_usage => [
                'Device Usage', data_sources[:localhost].id,
                nil
            ],
            :weekly_usage_trend => [
                'Weekly Usage Trend', data_sources[:localhost].id,
                nil
            ],
            :error_report => [
                'Error Report', data_sources[:localhost].id,
                nil
            ],
            :daily_usage_trend => [
                'Daily Usage Trend', data_sources[:localhost].id,
                nil
            ],
        }
    data_segments = SeedDataHelper.create_or_update_objects(DataSegment, data_segment_fields, data_segment_seeds)

    # Queries #######################################

    query_fields = [:name, :query_string, :store_in_db, :data_segment_id, :sample_data]
    query_seeds =
        {
            :error_scatterplot_query_1 => [
                'error 1', 'error scatterplot query 1', true, data_segments[:error_scatterplot].id,
                File.open("#{fixtures_path}/query_data/error_scatterplot_data_1.json").read
            ],
            :data_by_technology_query_1 => [
                'data by technology 1', File.open("#{fixtures_path}/queries/data_by_technology_query_1.txt").read,
                true, data_segments[:data_by_technology].id,
                File.open("#{fixtures_path}/query_data/data_by_technology_data_1.json").read
            ],
            :licensing_report_query_1 => [
                'new customers', 'new customers query', true, data_segments[:licensing_report].id,
                File.open("#{fixtures_path}/query_data/licensing_report_data_1.json").read
            ],
            :licensing_report_query_2 => [
                'returning customers', 'returning customers query', true, data_segments[:licensing_report].id,
                File.open("#{fixtures_path}/query_data/licensing_report_data_2.json").read
            ],
            :licensing_report_query_3 => [
                'lost customers', 'lost customers query', true, data_segments[:licensing_report].id,
                File.open("#{fixtures_path}/query_data/licensing_report_data_3.json").read
            ],
            :licensing_report_query_4 => [
                'churn', 'churn query', true, data_segments[:licensing_report].id,
                File.open("#{fixtures_path}/query_data/licensing_report_data_4.json").read
            ],
            :usage_trend_query_1 => [
                'average data uploaded and downloaded', 'average data uploaded and downloaded query',
                true, data_segments[:usage_trend].id,
                File.open("#{fixtures_path}/query_data/usage_trend_data_1.json").read
            ],
            :usage_trend_query_2 => [
                'failure rate (%)', 'failure rate (%) query', true, data_segments[:usage_trend].id,
                File.open("#{fixtures_path}/query_data/usage_trend_data_2.json").read
            ],
            :usage_trend_query_3 => [
                'connections / day', 'connections / day query', true, data_segments[:usage_trend].id,
                File.open("#{fixtures_path}/query_data/usage_trend_data_3.json").read
            ],
            :device_usage_piechart_query_1 => [
                'device usage', 'device usage piechart query 1', true, data_segments[:device_usage].id,
                File.open("#{fixtures_path}/query_data/device_usage_piechart_data_1.json").read
            ],
            :weekly_usage_trend_query_1 => [
                'connections / day(weekly)', 'connections / day query(weekly)', true,
                data_segments[:weekly_usage_trend].id,
                File.open("#{fixtures_path}/query_data/weekly_usage_data_1.json").read
            ],
            :weekly_usage_trend_query_2 => [
                'average data uploaded and downloaded(weekly)', 'average data uploaded and downloaded query(weekly)',
                true, data_segments[:weekly_usage_trend].id,
                File.open("#{fixtures_path}/query_data/weekly_usage_data_2.json").read
            ],
            :weekly_usage_trend_query_3 => [
                'failure rate (%)(weekly)', 'failure rate (%) query(weekly)', true,
                data_segments[:weekly_usage_trend].id,
                File.open("#{fixtures_path}/query_data/weekly_usage_data_3.json").read
            ],
            :daily_usage_trend_query_1 => [
                'connections / day(daily)', 'connections / day query(daily)', true,
                data_segments[:daily_usage_trend].id,
                File.open("#{fixtures_path}/query_data/daily_usage_data_1.json").read
            ],
            :daily_usage_trend_query_2 => [
                'average data uploaded and downloaded(daily)', 'average data uploaded and downloaded query(daily)',
                true, data_segments[:daily_usage_trend].id,
                File.open("#{fixtures_path}/query_data/daily_usage_data_2.json").read
            ],
            :daily_usage_trend_query_3 => [
                'failure rate (%)(daily)', 'failure rate (%) query(daily)', true,
                data_segments[:daily_usage_trend].id,
                File.open("#{fixtures_path}/query_data/daily_usage_data_3.json").read
            ],
            :error_report_query_1 => [
                'error report', 'error report query', true, data_segments[:error_report].id,
                File.open("#{fixtures_path}/query_data/error_report_data_1.json").read
            ],
        }
    queries = SeedDataHelper.create_or_update_objects(Query, query_fields, query_seeds)

    # Reports #######################################

    chart_report_fields = [:name, :sample_option, :tag_list, :queries, :highcharts_params]
    chart_report_seeds =
        {
            :error_scatterplot => [
                'Error Scatterplot', Query::Sample::PORTAL_JSON, 'Error Management',
                [
                    queries[:error_scatterplot_query_1]
                ],
                File.open("#{fixtures_path}/reports/error_scatterplot_highcharts.json").read
            ],

            :device_usage => [
                'Device Usage', Query::Sample::PORTAL_JSON, 'Customer Profiling',
                [
                    queries[:device_usage_piechart_query_1]
                ],
                File.open("#{fixtures_path}/reports/device_usage_highcharts.json").read
            ],

            :data_by_technology => [
                'Data by Technology', Query::Sample::REMOTE, 'Customer Profiling',
                [
                    queries[:data_by_technology_query_1],
                    queries[:data_by_technology_query_1]
                ],
                File.open("#{fixtures_path}/reports/data_by_technology_highcharts.json").read
            ],
            :licensing_report => [
                'Licensing Report', Query::Sample::PORTAL_JSON, 'Customer Profiling',
                [
                    queries[:licensing_report_query_1],
                    queries[:licensing_report_query_2],
                    queries[:licensing_report_query_3],
                    queries[:licensing_report_query_4]
                ],
                File.open("#{fixtures_path}/reports/licensing_report_highcharts.json").read
            ],
            :usage_trend_report => [
                'Usage Trend', Query::Sample::PORTAL_JSON, 'Customer Profiling',
                [
                    queries[:usage_trend_query_1],
                    queries[:usage_trend_query_2],
                    queries[:usage_trend_query_3]
                ],
                File.open("#{fixtures_path}/reports/usage_trend_highcharts.json").read
            ],
            :weekly_usage_trend => [
                'Weekly Usage Trend', Query::Sample::PORTAL_JSON, 'Customer Profiling',
                [
                    queries[:weekly_usage_trend_query_1],
                    queries[:weekly_usage_trend_query_2],
                    queries[:weekly_usage_trend_query_3]
                ],
                File.open("#{fixtures_path}/reports/weekly_usage_trend_highcharts.json").read
            ],
            :daily_usage_trend => [
                'Daily Usage Trend', Query::Sample::PORTAL_JSON, 'Customer Profiling',
                [
                    queries[:daily_usage_trend_query_1],
                    queries[:daily_usage_trend_query_2],
                    queries[:daily_usage_trend_query_3]
                ],
                File.open("#{fixtures_path}/reports/daily_usage_trend_highcharts.json").read
            ]
        }
    chart_reports = SeedDataHelper.create_or_update_objects(ChartReport, chart_report_fields, chart_report_seeds)

    table_report_fields = [:name, :sample_option, :tag_list, :queries, :table_columns]
    table_report_seeds =
        {
            :error_report => [
                'Error Report', Query::Sample::PORTAL_JSON, 'Error Management',
                [
                    queries[:error_report_query_1]
                ],
                "e_code, c_type, p_u, f_h, tot"
            ]
        }
    table_reports = SeedDataHelper.create_or_update_objects(TableReport, table_report_fields, table_report_seeds)

    # Report Query attributes #######################################

    # Set Default Values for ScatterPlot
    chart_reports[:error_scatterplot].report_queries.where(
        :query_id => queries[:error_scatterplot_query_1].id).first.update_attributes(
        {:chart_type =>'scatter', :y_column => 'sum_avg_141_142', :x_column => 'x', :radius_column => 'radius_data'}
    )

    #set default values to "Data by technology chart"
    ['3GDevice', '4GDevice'].each_with_index { |device_type, i|
      query_name = "data_by_technology_query_1"
      sql_string = "SELECT avg_upload_download, server_date FROM sample_results_1\n" +
          "WHERE devicetype = \"#{device_type}\";"
      chart_reports[:data_by_technology].report_queries.where(
          :query_id => queries[query_name.to_sym].id).first.update_attributes(
          {
              :chart_type => 'area',
              :y_column => 'avg_upload_download',
              :x_column => 'server_date',
              :sql_string => sql_string
          }
      )
    }

    chartType = ["area", "line", "line"]
    # Set default values to Daily Usage Trend chart
    ['sum_avg_141_142', 'sum_avg_143_144', 'sum_avg_145_146'].each_with_index { |y_col, i|
      query_name = "daily_usage_trend_query_" + (i+1).to_s()
      chart_reports[:daily_usage_trend].report_queries.where(
          :query_id => queries[query_name.to_sym].id).first.update_attributes(
          {:chart_type => chartType[i], :y_column => y_col, :x_column => 'hour'}
      )
    }

    # Set default values to Weekly Usage Trend chart
    ['sum_avg_141_142', 'sum_avg_143_144', 'sum_avg_145_146'].each_with_index { |y_col, i|
      query_name = "weekly_usage_trend_query_" + (i+1).to_s()
      chart_reports[:weekly_usage_trend].report_queries.where(
          :query_id => queries[query_name.to_sym].id).first.update_attributes(
          {:chart_type => chartType[i], :y_column => y_col, :x_column => 'day'}
      )
    }

    # Set default values to "Usage Trend report chart"
    ['sum_avg_141_142', 'sum_avg_143_144', 'sum_avg_145_146'].each_with_index { |y_col, i|
      query_name = "usage_trend_query_" + (i+1).to_s()
      chart_reports[:usage_trend_report].report_queries.where(
          :query_id => queries[query_name.to_sym].id).first.update_attributes(
          {:chart_type => chartType[i], :y_column => y_col, :x_column => 'date'}
      )
    }

    # Set Default Values for Device Usage Pie Chart
    chart_reports[:device_usage].report_queries.where(
        :query_id => queries[:device_usage_piechart_query_1].id).first.update_attributes(
        {:chart_type =>'pie', :y_column => 'device_usage_percentage', :x_column => 'device_name'}
    )

    # Set default values to "Custer Profiling - Licensing Report"
    colors = ["#89A54E", "#4572A7", "#AA4643"]
    ['sum_avg_141_142', 'sum_avg_143_144', 'sum_avg_145_146'].each_with_index { |y_col, i|
      query_name = "licensing_report_query_" + (i+1).to_s()
      chart_reports[:licensing_report].report_queries.where(
          :query_id => queries[query_name.to_sym].id).first.update_attributes(
          {:chart_type => 'column', :y_column => y_col, :x_column => 'date',
           :chart_params => '{ "color":"' + colors[i] + '"}'}
      )
      chart_reports[:licensing_report].report_queries.where(
          :query_id => queries[:licensing_report_query_4].id).first.update_attributes(
          {:chart_params => '{"color":"#F88017"}', :y_column => 'sum_avg_147_148', :x_column => 'date'}
      )
    }
  end
end
