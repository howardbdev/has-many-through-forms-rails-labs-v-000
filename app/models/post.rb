class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments
  # accepts_nested_attributes_for :categories

  def uniq_users_list
    users = self.users.collect
    users.map {|u| u }.uniq
  end

  def categories_attributes=(attributes_hashes)
    attributes_hashes.each do |index_key, attribute_hash|
      category = Category.find_or_create_by(name: attribute_hash[:name])
      self.post_categories.build(category: category)
    end
  end

end
