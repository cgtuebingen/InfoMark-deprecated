require 'rails_helper'

RSpec.describe "exam_grades/index", type: :view do
  before(:each) do
    assign(:exam_grades, [
      ExamGrade.create!(
        :points => 1,
        :mark => 2,
        :info => "MyText",
        :user => nil,
        :exam => nil
      ),
      ExamGrade.create!(
        :points => 1,
        :mark => 2,
        :info => "MyText",
        :user => nil,
        :exam => nil
      )
    ])
  end

  it "renders a list of exam_grades" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
