require 'test_helper'

class RubricsControllerTest < ActionController::TestCase
  setup do
    @rubric = rubrics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rubrics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rubric" do
    assert_difference('Rubric.count') do
      post :create, :rubric => @rubric.attributes
    end

    assert_redirected_to rubric_path(assigns(:rubric))
  end

  test "should show rubric" do
    get :show, :id => @rubric.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @rubric.to_param
    assert_response :success
  end

  test "should update rubric" do
    put :update, :id => @rubric.to_param, :rubric => @rubric.attributes
    assert_redirected_to rubric_path(assigns(:rubric))
  end

  test "should destroy rubric" do
    assert_difference('Rubric.count', -1) do
      delete :destroy, :id => @rubric.to_param
    end

    assert_redirected_to rubrics_path
  end
end
