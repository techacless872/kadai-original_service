class MiscsController < ApplicationController
  def top
    if logged_in?
      @task = current_user.tasks.build  # form_for 用
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page]).per(25)
    end
  end  
end
