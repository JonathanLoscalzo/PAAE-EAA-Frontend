class PaymentForm < ActiveRecord::Base
  has_many :vfps
  has_many :sales, through: :vfps
end
