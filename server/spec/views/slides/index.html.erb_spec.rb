require 'rails_helper'

RSpec.describe "slides/index", type: :view do
  before(:each) do
    assign(:slides, [
      Slide.create!(
        :file => "File",
        :course => nil,
        :public => false,
        :info => "Info",
        :title => "Title"
      ),
      Slide.create!(
        :file => "File",
        :course => nil,
        :public => false,
        :info => "Info",
        :title => "Title"
      )
    ])
  end

  it "renders a list of slides" do
    render
    assert_select "tr>td", :text => "File".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Info".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
