class TodosController < ApplicationController
  before_action :authenticated_user

  def index
    @todos = @authenticated_user.todos.all
    render json: @todos
  end

  def show
    @todo = Todo.find(params[:id])
    render json: todo
    if @authenticated_user.todos.exists?(is: params:[:id])
      @todo = @authenticated_user.todos.find(params:id)
    else
      render json: {"status": 403, "message": "権限ないよ"}
    end
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      render json: {status: 200, message: 'タスクを作成しました'}
    else
      render json: {status: 400, message: @todo.errors.full_messages}
    end
  end

    private

    def todo_params
      params.fetch(:todo, {}).permit(:title, :description, :status, :user_id)
    end
end
