class Product < ApplicationRecord
  belongs_to :category

  validates :description, :price, :category, presence: true

  def formatted_price
    "$%.2f" % price
  end
end
