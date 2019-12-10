class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    authorize @user
    render json: @user, include: [:teacher]
  end
end