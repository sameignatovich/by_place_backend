json.user do
  json.username @user.username
  json.fullname @user.fullname
  json.avatar polymorphic_url(@user.avatar) if @user.avatar.attached?
end