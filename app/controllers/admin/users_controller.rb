class Admin::UsersController < ApplicationController
  before_action :check_admin_access
  before_action :set_user, only: [:destroy]

  # GET /admin/users.json
  def index
    @users = User.all.with_attached_avatar
  end

  # DELETE /admin/places/:id.json
  def destroy
    if @user.destroy
      render json: {message: 'User destroyed'}, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
end
