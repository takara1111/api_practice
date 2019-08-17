class TodosController < ApplicationController
  before_action :authenticated_user
  before_action :user_todos, only: [:show, :update]

  def index
    @todos = @authenticated_user.todos.all
    render json: @todos
  end

  def show
    @todo = @authenticated_user.todos.find(params[:id])
    render json: @todo
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      render json: {status: 200, message: 'タスクを作成しました'}
    else
      render json: {status: 400, message: @todo.errors.full_messages}
    end
  end

  def update
    @todo = Todo.find(params[:id])
    if @todo.update(todo_params)
      render json: {"status": 200, "message": "タスクを更新しました"}
    else
      render json: {status: 400, message: @todo.errors.full_messages}
    end
  end

    private

    def user_todos
      unless @authenticated_user.todos.exists?(id: params[:id])
        render jdon: {"status": 403, "message": "権限ないよ"}
      end
    end

    def todo_params
      raw_parameters = {
        title: params[:title],
        description: params[:description],
        status: params[:status],
        user_id: @authenticated_user.id
      }
      parameters = ActionContoller::Parameters.new(raw_parameters)
      parameters.permit(:title, :description, :status, :user_id)
    end
end
