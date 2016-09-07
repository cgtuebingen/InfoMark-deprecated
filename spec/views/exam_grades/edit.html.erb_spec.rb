require 'rails_helper'

RSpec.describe "exam_grades/edit", type: :view do
  before(:each) do
    @exam_grade = assign(:exam_grade, ExamGrade.create!(
      :points => 1,
      :mark => 1,
      :info => "MyText",
      :user => nil,
      :exam => nil
    ))
  end

  it "renders the edit exam_grade form" do
    render

    assert_select "form[action=?][method=?]", exam_grade_path(@exam_grade), "post" do

      assert_select "input#exam_grade_points[name=?]", "exam_grade[points]"

      assert_select "input#exam_grade_mark[name=?]", "exam_grade[mark]"

      assert_select "textarea#exam_grade_info[name=?]", "exam_grade[info]"

      assert_select "input#exam_grade_user_id[name=?]", "exam_grade[user_id]"

      assert_select "input#exam_grade_exam_id[name=?]", "exam_grade[exam_id]"
    end
  end
end
