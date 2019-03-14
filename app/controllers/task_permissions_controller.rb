class TaskPermissionsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    task = Task.find(params[:task_id])
    current_user.select(task)
    flash[:success] = 'タスクをフォローしました。'
    redirect_to root_url
  end

  def destroy
    task = Task.find(params[:task_id])
    current_user.deselect(task)
    flash[:success] = 'タスクのフォローを解除しました。'
    redirect_to root_url
  end
end
