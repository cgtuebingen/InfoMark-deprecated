require 'rails_helper'

RSpec.describe "exercise_tasks/new", type: :view do
  before(:each) do
    assign(:exercise_task, ExerciseTask.new())
  end

  it "renders new exercise_task form" do
    render

    assert_select "form[action=?][method=?]", exercise_tasks_path, "post" do
    end
  end
end
