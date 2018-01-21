require 'rails_helper'

RSpec.describe "exam_grades/show", type: :view do
  before(:each) do
    @exam_grade = assign(:exam_grade, ExamGrade.create!(
      :points => 1,
      :mark => 2,
      :info => "MyText",
      :user => nil,
      :exam => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
