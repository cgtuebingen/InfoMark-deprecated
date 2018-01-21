require 'rails_helper'

RSpec.describe "exercise_tasks/show", type: :view do
  before(:each) do
    @exercise_task = assign(:exercise_task, ExerciseTask.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
