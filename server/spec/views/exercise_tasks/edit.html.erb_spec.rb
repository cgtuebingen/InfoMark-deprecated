require 'rails_helper'

RSpec.describe "exercise_tasks/edit", type: :view do
  before(:each) do
    @exercise_task = assign(:exercise_task, ExerciseTask.create!())
  end

  it "renders the edit exercise_task form" do
    render

    assert_select "form[action=?][method=?]", exercise_task_path(@exercise_task), "post" do
    end
  end
end
