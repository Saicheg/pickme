class User
  include Mongoid::Document

  mount_uploader :photo, PhotoUploader

  field :vk_id, type: Integer
  field :email, type: String
  field :name,  type: String
end
