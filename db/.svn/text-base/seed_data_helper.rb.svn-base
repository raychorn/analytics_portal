require 'csv'

class ActiveRecord::Base
  # http://railspikes.com/2008/2/1/loading-seed-data
  # http://blogwi.se/post/47083009/slightly-pimped-activerecord-create-or-update
  # http://www.mbleigh.com/2008/2/19/activerecord-base-create_or_update-on-steroids
  # given a hash of attributes including the ID, look up the record by ID.
  # If it does not exist, it is created with the rest of the options.
  # If it exists, it is updated with the given options.
  #
  # Raises an exception if the record is invalid to ensure seed data is loaded correctly.
  #
  # Returns the record.
  def self.create_or_update_by(attr_sym, attr_value, options = {})
#    id = options.delete(:id)

    record = where(attr_sym => attr_value).first || new(attr_sym => attr_value)
    record.attributes = options
    record.save!
    record
  end
end

module SeedDataHelper
  def self.create_or_update_objects(class_type, seed_fields, seeds_hash)
    puts "#### seeding #{class_type} ####"
    objects_hash = {}
    seeds_hash.each do |obj_key, obj_attributes|
      options = {}
      seed_fields.each_index do |i|
        options[seed_fields[i]] = obj_attributes[i]
      end
      objects_hash[obj_key] = class_type.send(:create_or_update_by, seed_fields[0], obj_attributes[0], options)
    end
    objects_hash
  end

  def self.create_or_update_objects_from_csv_by(class_type, unique_attr, file_path)
    puts "#### seeding #{class_type} ####"

    csv_file = File.new(file_path, 'r')
    # header has the Active Record attributes
    line = csv_file.gets
    header = CSV.parse_line(line)
    unique_attr_index = header.index(unique_attr.to_s)

    objects = []
    while (line = csv_file.gets)
      row = CSV.parse_line(line)
      unique_val = row[unique_attr_index]
      options = {}
      row.each_index do |i|
        if (header[i] == 'type') && (row[i] != 'NULL') && (row[i].present?)
          class_type = row[i].constantize
        end
        if (row[i] == 'NULL') || (row[i].blank?)
          options[header[i].to_sym] = nil
        else
          options[header[i].to_sym] = row[i]
        end
      end
      puts "..line=#{line}"
      puts "  row=#{row.inspect}"
      obj = class_type.send(:create_or_update_by, unique_attr, unique_val, options)
      obj.save!
      objects << obj
    end
    objects
  end
end
