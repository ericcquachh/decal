class Category < ActiveRecord::Base
  attr_accessible :name

  def self.categories
    self.all.map {|t| t.name }
  end

end
