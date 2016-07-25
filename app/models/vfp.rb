class Vfp < ActiveRecord::Base
  belongs_to :sale
  belongs_to :payment_form
end
