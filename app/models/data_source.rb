class DataSource < ActiveRecord::Base
  validates_presence_of :name, :url, :database_name
  validates_uniqueness_of :name

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end
