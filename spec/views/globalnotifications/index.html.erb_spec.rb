require 'rails_helper'

RSpec.describe "globalnotifications/index", type: :view do
  before(:each) do
    assign(:globalnotifications, [
      Globalnotification.create!(
        :body => "MyText",
        :visibility => 1
      ),
      Globalnotification.create!(
        :body => "MyText",
        :visibility => 1
      )
    ])
  end

  it "renders a list of globalnotifications" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
