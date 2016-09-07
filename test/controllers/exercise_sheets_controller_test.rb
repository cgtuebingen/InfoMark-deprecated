require 'test_helper'

class ExerciseSheetsControllerTest < ActionController::TestCase
  setup do
    @exercise_sheet = exercise_sheets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:exercise_sheets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create exercise_sheet" do
    assert_difference('ExerciseSheet.count') do
      post :create, exercise_sheet: { course_id: @exercise_sheet.course_id, description: @exercise_sheet.description, duedate: @exercise_sheet.duedate, file: @exercise_sheet.file, order: @exercise_sheet.order, publish: @exercise_sheet.publish, user_id: @exercise_sheet.user_id }
    end

    assert_redirected_to exercise_sheet_path(assigns(:exercise_sheet))
  end

  test "should show exercise_sheet" do
    get :show, id: @exercise_sheet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @exercise_sheet
    assert_response :success
  end

  test "should update exercise_sheet" do
    patch :update, id: @exercise_sheet, exercise_sheet: { course_id: @exercise_sheet.course_id, description: @exercise_sheet.description, duedate: @exercise_sheet.duedate, file: @exercise_sheet.file, order: @exercise_sheet.order, publish: @exercise_sheet.publish, user_id: @exercise_sheet.user_id }
    assert_redirected_to exercise_sheet_path(assigns(:exercise_sheet))
  end

  test "should destroy exercise_sheet" do
    assert_difference('ExerciseSheet.count', -1) do
      delete :destroy, id: @exercise_sheet
    end

    assert_redirected_to exercise_sheets_path
  end
end
