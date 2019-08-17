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
      raw_parameters = {title: params[:title], description: params[:description], user_id: @authenticated_user.id}
      parameters = ActionContoller::Parameters.new(raw_parameters)
      parameters.permit(:title, :description, :user_id)
    end
end
