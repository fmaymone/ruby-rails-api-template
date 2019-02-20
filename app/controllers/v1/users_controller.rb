module V1
  class UsersController < ApplicationController
      before_action :set_user, only: [:show, :update, :destroy, :update_role]
  
    # GET /Users
    def index
      if current_user.role != 'admin' and current_user.role != 'manager'
        Rails.logger.debug current_user.role 
        raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
      end
      @users = User.all.paginate(page: params[:page], per_page: 20)
      json_response(@users)
    end
  
    # POST /Users
    def create
      if current_user.role != 'admin' and current_user.role != 'manager'
        Rails.logger.debug current_user.role 
        raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
      end
      @user = current_user.Users.create!(user_params)
      json_response(@user, :created)
    end
  
    # GET /Users/:id
    def show
      if current_user.role != 'admin' and current_user.role != 'manager' and
        @user.id != current_user.id
        raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
      end
      json_response(@user)
    end
  
    # PUT /Users/:id
    def update
      if current_user.role != 'admin' and current_user.role != 'manager' and
        @user.id != current_user.id
        raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
      end
      @user.update_attribute(:name, user_params[:name])
      head :no_content
    end
  
    # DELETE /Users/:id
    def destroy
      if current_user.role != 'admin' and current_user.role != 'manager'
        raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
      end
      @user.destroy
      head :no_content
    end
    
    # PUT /Users/:id/role
    def update_role
      if current_user.role != 'admin'
        raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
      end
      @user.update(update_role_params)
      head :no_content
    end
  
    private
    
    def update_role_params
      params.permit(:role)
    end
  
    def user_params
      # whitelist params
      params.permit(:name, :id, :user)
    end
  
    def set_user
      @user = User.find(params[:id])
    end
  end
end