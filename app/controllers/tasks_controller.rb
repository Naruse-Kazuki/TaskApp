class TasksController < ApplicationController
  before_action :set_user, only: [:edit, :updat, :destroy]
  before_action :logged_in_user, only: [:update, :edit, :destroy]
  before_action :admin_or_correct_user, only: [:update, :edit, :destroy]

  def index
    @tasks = Task.all
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    @task.user = current_user
    if @task.save
      flash[:success] = '新規登録に成功しました。'
      redirect_to user_tasks_url
    else
      render :new
    end
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    if @task.save
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
    redirect_to tasks_url
  end
  
  private
  
    def task_params
      params.require(:task).permit(:task_name, :note)
    end
    
    def set_user
      @user = User.find(params[:id])
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end

    def correct_user
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to root_url unless current_user.admin?
    end
    
    def admin_or_correct_user
      @user = User.find(params[:user_id]) if @user.blank?
      unless current_user?(@user) || current_user.admin?
        flash[:danger] = "編集権限がありません。"
        redirect_to(root_url)
      end  
    end
    
end