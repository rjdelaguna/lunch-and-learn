class Favorite <ApplicationRecord
  validates_presence_of :country, :recipe_link, :recipe_title

  belongs_to :user
end