class ApplicationController < ActionController::Base
    def authorized
        current_user.id == @task.user_id
    end
    helper_method :authorized
end
