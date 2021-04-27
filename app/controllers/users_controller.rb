class UsersController < ApplicationController
  before_action :set_user, only: %i[ show liked feed followers following discover ]
  before_action :show_feed_and_discover_only_to_current_user, only: [:feed, :discover]

  private

    def set_user
      if params[:username]
        @user = User.find_by!(username: params.fetch(:username))
      else
        @user = current_user
      end
    end

    def show_feed_and_discover_only_to_current_user
      if current_user != @user
      redirect_back fallback_location: root_url, alert: "You are not authorized for that"
      end
    end
end