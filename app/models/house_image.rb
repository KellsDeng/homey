class HouseImage < ApplicationRecord
  mount_uploader :image,HouseImageUploader
  belongs_to :house ,:optional=>true
end
