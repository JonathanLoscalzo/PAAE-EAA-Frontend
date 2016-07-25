class Client < ActiveRecord::Base
  has_many :sales

  def complete_name
    :"#{first_name.first}. #{last_name} #{dni}"
  end
end
