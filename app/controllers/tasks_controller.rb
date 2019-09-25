class TasksController < ApplicationController
  
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = '新規登録に成功しました。'
      redirect_to @task
    else
      render :new
    end
  end
  
  def index
    @tasks = Task.all
  end
  
  def show
    @task = Task.find(params[:id])
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
  
end
