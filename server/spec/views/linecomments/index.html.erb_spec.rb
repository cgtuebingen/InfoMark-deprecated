require 'rails_helper'

RSpec.describe "linecomments/index", type: :view do
  before(:each) do
    assign(:linecomments, [
      Linecomment.create!(
        :submission => nil,
        :file_name => "File Name",
        :line => 1,
        :comment => "Comment",
        :user => nil
      ),
      Linecomment.create!(
        :submission => nil,
        :file_name => "File Name",
        :line => 1,
        :comment => "Comment",
        :user => nil
      )
    ])
  end

  it "renders a list of linecomments" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "File Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Comment".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
