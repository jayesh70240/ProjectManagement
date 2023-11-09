class ApplicationController < ActionController::Base
before_action :configure_permitted_parameters, if: :devise_controller?
before_action :authenticate_user!

    # def authorized
    #     current_user.id == @task.user_id || (current_user.role == 'manager' || current_user.role == 'admin')
    # end

    def authorized
      current_user.id == @task.user_id || current_user.role.in?(['manager', 'admin']) && current_user.projects.include?(@task.project)
    end
    
    helper_method :authorized


  protected

    def configure_permitted_parameters
      # for adding a paramater to create 
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :role])

      # for adding a paramater to update to solve unpermitted_parameter issue 
      added_attrs = [:username, :role, :password, :password_confirmation, :current_password]
      devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
    end
end
