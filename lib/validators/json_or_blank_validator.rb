class JsonOrBlankValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    begin
      if value.present?
        JSON.parse(value)
      end
    rescue
      object.errors[attribute] << (options[:message] || "is not valid JSON")
    end
  end
end