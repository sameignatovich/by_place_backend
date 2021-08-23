class Admin::UsersController < ApplicationController
  before_action :check_admin_access

  # GET /v1/profiles.json
  def index
    @users = User.all

    render json: { users: @users }
  end
end
