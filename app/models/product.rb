class Product < ActiveRecord::Base
  has_many :batches
  belongs_to :supplier
end
