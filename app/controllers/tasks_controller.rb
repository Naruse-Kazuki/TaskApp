class TasksController < ApplicationController
  before_action :set_user, only: [:index, :show, :new, :create, :edit, :updat, :destroy]
  before_action :logged_in_user, only: [:index, :show, :create, :update, :edit, :destroy]
  before_action :correct_user, only: [:index, :show, :create, :update, :edit, :destroy]

  def index
    @task = @user.tasks.all
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def new
    @task = @user.tasks.new
 
  end
  
  def create
    @task = @user.tasks.create(task_params)
    if @task.save
      flash[:success] = '新規登録に成功しました。'
      redirect_to user_tasks_url @user
    else
      render :new
    end
  end
  
  def edit
    @task = @user.tasks.find(params[:id])
  end
  
  def update
    @task = @user.tasks.find(params[:id])
    if @task.update_attributes(task_params)
      flash[:success] = 'タスク編集に成功しました。'
      redirect_to @task
    else
      render :edit
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.user = current_user
    @task.destroy
    redirect_to user_tasks_url
  end
  
  private
  
    def task_params
      params.require(:task).permit(:task_name, :note, :user_id)
    end
    
    def correct_user
      redirect_to(root_url) unless current_user?(@user)
    end
    
end