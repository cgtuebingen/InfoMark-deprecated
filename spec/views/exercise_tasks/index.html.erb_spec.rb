require 'rails_helper'

RSpec.describe "exercise_tasks/index", type: :view do
  before(:each) do
    assign(:exercise_tasks, [
      ExerciseTask.create!(),
      ExerciseTask.create!()
    ])
  end

  it "renders a list of exercise_tasks" do
    render
  end
end
