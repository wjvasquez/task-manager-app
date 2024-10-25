class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result.order(due_date: :asc)
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      redirect_to @task, notice: "Task was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def update
    @task = current_user.tasks.find(params[:id])

    if @task.update(task_params)
      redirect_to @task, notice: "Task was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task = current_user.tasks.find(params[:id])
    @task.destroy

    redirect_to root_path, notice: "Task was successfully deleted.", status: :see_other
  end

  def update_status
    @task = current_user.tasks.find(params[:id])

    if @task.update(status: params[:status])
      redirect_to @task, notice: "Task status changed successfully!"
    else
      redirect_to @task, alert: "Unable to chaged the task status!"
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :status)
  end
end
