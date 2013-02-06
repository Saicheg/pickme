json.user_left do
  json.image @user_left.photo.try(:url, :normalized)
  json.link picks_path(uuid: @url_encoder.encode(@user_left.id, @user_right.id))
end

json.user_right do
  json.image @user_right.photo.try(:url, :normalized)
  json.link picks_path(uuid: @url_encoder.encode(@user_right.id, @user_left.id))
end
