require 'test_helper'

class TodosInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "todo interface with Ajax" do
    log_in_as @user
    get root_path
    # invalid submit
    assert_no_difference 'Todo.count' do
      xhr :post, user_todos_path(user_id: @user.id), todo: { content: '' }
    end
    # valid submit
    assert_difference 'Todo.count', 1 do
      xhr :post, user_todos_path(user_id: @user.id), todo: { content: 'content' }
    end
    # delete one todo
    first_todo = @user.todos.first
    assert_difference 'Todo.count', -1 do
       xhr :delete, user_todo_path(user_id: @user.id, id: first_todo)
    end
  end

  test "todo interface" do
    log_in_as @user
    get root_path
    # invalid submit
    assert_no_difference 'Todo.count' do
      post user_todos_path(user_id: @user.id), todo: { content: '' }
    end
    assert_redirected_to root_url
    # valid submit
    content = 'content'
    assert_difference 'Todo.count', 1 do
      post user_todos_path(user_id: @user.id), todo: { content: content }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    # delete one todo
    first_todo = @user.todos.first
    assert_difference 'Todo.count', -1 do
      delete user_todo_path(user_id: @user.id, id: first_todo)
    end
  end
end
