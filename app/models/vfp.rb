class Vfp < ActiveRecord::Base
  belongs_to :sales
  belongs_to :payment_form
end
