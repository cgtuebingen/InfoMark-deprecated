require 'rails_helper'

RSpec.describe "exam_grades/new", type: :view do
  before(:each) do
    assign(:exam_grade, ExamGrade.new(
      :points => 1,
      :mark => 1,
      :info => "MyText",
      :user => nil,
      :exam => nil
    ))
  end

  it "renders new exam_grade form" do
    render

    assert_select "form[action=?][method=?]", exam_grades_path, "post" do

      assert_select "input#exam_grade_points[name=?]", "exam_grade[points]"

      assert_select "input#exam_grade_mark[name=?]", "exam_grade[mark]"

      assert_select "textarea#exam_grade_info[name=?]", "exam_grade[info]"

      assert_select "input#exam_grade_user_id[name=?]", "exam_grade[user_id]"

      assert_select "input#exam_grade_exam_id[name=?]", "exam_grade[exam_id]"
    end
  end
end
