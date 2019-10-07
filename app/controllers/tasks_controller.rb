class TasksController < ApplicationController


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
    
end