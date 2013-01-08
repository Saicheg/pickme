class User
  include Mongoid::Document

  mount_uploader :photo, PhotoUploader

  field :vk_id, type: Integer
  field :first_name,  type: String
  field :last_name,   type: String
  field :nickname,    type: String
  field :screen_name, type: String
  field :sex,         type: String
  field :bdate,       type: String
  field :city,        type: String
  field :country,     type: String
  field :timezone,    type: String

end
