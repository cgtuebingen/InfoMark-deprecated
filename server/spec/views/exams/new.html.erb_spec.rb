require 'rails_helper'

RSpec.describe "exams/new", type: :view do
  before(:each) do
    assign(:exam, Exam.new(
      :title => "MyString",
      :course => nil,
      :info => "MyText"
    ))
  end

  it "renders new exam form" do
    render

    assert_select "form[action=?][method=?]", exams_path, "post" do

      assert_select "input#exam_title[name=?]", "exam[title]"

      assert_select "input#exam_course_id[name=?]", "exam[course_id]"

      assert_select "textarea#exam_info[name=?]", "exam[info]"
    end
  end
end
