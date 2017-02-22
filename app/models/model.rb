class Model < ActiveRecord::Base
  belongs_to :product
  belongs_to :var
end
