require 'rails_helper'

RSpec.describe "exams/edit", type: :view do
  before(:each) do
    @exam = assign(:exam, Exam.create!(
      :title => "MyString",
      :course => nil,
      :info => "MyText"
    ))
  end

  it "renders the edit exam form" do
    render

    assert_select "form[action=?][method=?]", exam_path(@exam), "post" do

      assert_select "input#exam_title[name=?]", "exam[title]"

      assert_select "input#exam_course_id[name=?]", "exam[course_id]"

      assert_select "textarea#exam_info[name=?]", "exam[info]"
    end
  end
end
