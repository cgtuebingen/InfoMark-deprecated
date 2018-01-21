require 'rails_helper'

RSpec.describe "exams/index", type: :view do
  before(:each) do
    assign(:exams, [
      Exam.create!(
        :title => "Title",
        :course => nil,
        :info => "MyText"
      ),
      Exam.create!(
        :title => "Title",
        :course => nil,
        :info => "MyText"
      )
    ])
  end

  it "renders a list of exams" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
