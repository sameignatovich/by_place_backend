class Admin::UsersController < ApplicationController
  before_action :check_admin_access

  # GET /admin/users.json
  def index
    @users = User.all.with_attached_avatar
  end
end
