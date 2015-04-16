require 'test_helper'

class TodoTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @todo = @user.todos.new(content: "Lorem ipsum")
  end

  test "should be valid" do
    assert @todo.valid?
  end

  test "user id should be present" do
    @todo.user_id = nil
    assert_not @todo.valid?
  end

  test "content should be present" do
    @todo.content = " "
    assert_not @todo.valid?
  end

  test "content should be at most 140 characters" do
    @todo.content = "a" * 141
    assert_not @todo.valid?
  end
end
