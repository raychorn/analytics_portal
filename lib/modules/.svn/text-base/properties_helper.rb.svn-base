require 'properties-ruby'

module PropertiesHelper
  def self.get_or_use_default(properties, key, default)
    begin
      return properties.get(key)
    rescue RuntimeError
      return default
    end
  end
end