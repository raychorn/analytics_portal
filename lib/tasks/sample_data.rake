require_dependency "#{Rails.root}/db/seed_data_helper.rb"
require 'json'

namespace :app do
  desc <<-DESC
    Load sample data.
    Run using the command 'rake app:sample_data'
  DESC
  task :sample_data => [:environment] do
    raise "this task is no longer supported, use yaml_db task instead"
    # Only data not required in production should be here.
    # If it needs to be there in production, it belongs in seeds.rb.

#    csv_path = "#{Rails.root}/test/seed_data/data_sources.csv"
#    SeedDataHelper.create_or_update_objects_from_csv_by(DataSource, 'name', csv_path)
#
#    csv_path = "#{Rails.root}/test/seed_data/data_segments.csv"
#    SeedDataHelper.create_or_update_objects_from_csv_by(DataSegment, 'name', csv_path)
#
#    csv_path = "#{Rails.root}/test/seed_data/queries.csv"
#    SeedDataHelper.create_or_update_objects_from_csv_by(Query, 'name', csv_path)
#
#    csv_path = "#{Rails.root}/test/seed_data/reports.csv"
#    SeedDataHelper.create_or_update_objects_from_csv_by(Report, 'name', csv_path)
#
#    csv_path = "#{Rails.root}/test/seed_data/report_queries.csv"
#    SeedDataHelper.create_or_update_objects_from_csv_by(ReportQuery, 'id', csv_path)

  end

  desc <<-DESC
    Load demo users.
  DESC
  task :demo_users => [:environment] do

    # create "portal user" role
    portal_role_name = 'portal user'
    portal_role = Role.find_by_name(portal_role_name)
    portal_role ||= Role.new
    portal_role.attributes = {
      :name => portal_role_name
    }
    portal_role.permissions = [Permission::VIEW_ANALYTICS_AND_RUN_REPORTS]
    portal_role.save!

    csv_path = "#{Rails.root}/test/seed_data/users.csv"
    demo_users = SeedDataHelper.create_or_update_objects_from_csv_by(User, 'email', csv_path)
    demo_users.each do |u|
      u.add_role(portal_role)
      u.save!
    end

  end
end
