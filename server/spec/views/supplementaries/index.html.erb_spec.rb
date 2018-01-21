require 'rails_helper'

RSpec.describe "supplementaries/index", type: :view do
  before(:each) do
    assign(:supplementaries, [
      Supplementary.create!(
        :file => "File",
        :course => nil,
        :info => "Info"
      ),
      Supplementary.create!(
        :file => "File",
        :course => nil,
        :info => "Info"
      )
    ])
  end

  it "renders a list of supplementaries" do
    render
    assert_select "tr>td", :text => "File".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Info".to_s, :count => 2
  end
end
