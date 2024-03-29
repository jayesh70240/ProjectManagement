class TasksController < ApplicationController
before_action :set_task, only: [:edit, :update, :destroy, :complete]

    def index
        if params[:user_id]
            if User.find(params[:user_id])== current_user
                @user = User.find(params[:user_id])
                @tasks = @user.tasks
            else
                redirect_to projects_path
                flash[:notice] = "Unauthorized Access."
            end
        else
            @tasks = Task.all
        end
    end

    def new
        if params[:user_id]
            @user = User.find(params[:user_id])
            @task = @user.tasks.build
            @task = Task.new(user_id: @user.id)
        elsif params[:project_id]
            @project = Project.find(params[:project_id])
            @task = Task.new(project_id: @project.id)
        else
            @user = nil
            @task = Task.new
        end
    end

    def create
        @task = Task.new(task_params)
        # Find the user by user_id and set the username as assignedto
        user = User.find(params[:task][:user_id])
        @task.assignedto = user.username
        if @task.save
            redirect_to projects_path
        else
            render :new
        end
    end
    
    def edit
        if authorized
        else 
            redirect_to projects_path
            flash[:notice] = "You can only make changes to your Tasks."
        end
    end

    def update
        if @task.update(task_params)
            user = User.find(params[:task][:user_id])
            @task.assignedto = user.username
            redirect_to projects_path
        else
            render :edit
        end
    end
    
    def complete
        if authorized
            @task.update(completed: true)
            redirect_to projects_path
        else
            redirect_to projects_path
            flash[:notice] = "You can only complete your projects."
        end
    end

     def destroy
        if authorized
            @task.destroy
            redirect_to projects_path
        else
            redirect_to projects_path
            flash[:notice] = "You can only delete your own tasks."
        end
    end

    private

    def set_task
        @task = Task.find(params[:id])
    end

    def task_params
        params.require(:task).permit(:assignedto, :submittedto, :user_id, :project_id, :status, :submittedon)
    end
end
