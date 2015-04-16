require 'test_helper'

class TodosControllerTest < ActionController::TestCase

  def setup
    @user = users(:michael)
    @todo = todos(:book)
    @other_user = users(:lana)
  end

  test "should redirect create todo when not logged in" do
    assert_no_difference "Todo.count" do
      post :create, user_id: @user.id, todo: { content: "Lorem ipsum" }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy todo when not logged in" do
    assert_no_difference "Todo.count" do
      delete :destroy, user_id: @user.id, id: @todo
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong todo" do
    log_in_as(@other_user)
    assert_no_difference 'Todo.count' do
      delete :destroy, user_id: @user.id, id: @todo
    end
    assert_redirected_to root_url
  end
end