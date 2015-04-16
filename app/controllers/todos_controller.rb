class TodosController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: :destroy

  def create
    @todo = current_user.todos.build(todo_params)
    if @todo.save
      flash.now[:success] = "Todo created!"
    else
      flash.now[:danger] = "Todo create fail"
    end
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  def destroy
    @todo.destroy
    flash.now[:success] = "Todo deleted!"
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  private

    def todo_params
      params.require(:todo).permit(:content)
    end

    def correct_user
      @todo = current_user.todos.find_by(id: params[:id])
      redirect_to root_url if @todo.nil?
    end
end
