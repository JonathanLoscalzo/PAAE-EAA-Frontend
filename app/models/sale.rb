class Sale < ActiveRecord::Base
  has_many :vfps
  has_many :payment_forms, :through => :vfps
  has_many :sale_details
  belongs_to :client
  belongs_to :user
end
