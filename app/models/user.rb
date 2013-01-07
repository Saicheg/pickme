class User
  include Mongoid::Document

  mount_uploader :photo, PhotoUploader

  field :email, type: String
  field :name, type: String
end
