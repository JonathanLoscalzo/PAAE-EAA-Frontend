class Item < ActiveRecord::Base
	validates :name, :amount, :price, presence: true
end
