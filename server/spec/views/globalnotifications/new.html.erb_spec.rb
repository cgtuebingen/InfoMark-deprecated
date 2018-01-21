require 'rails_helper'

RSpec.describe "globalnotifications/new", type: :view do
  before(:each) do
    assign(:globalnotification, Globalnotification.new(
      :body => "MyText",
      :visibility => 1
    ))
  end

  it "renders new globalnotification form" do
    render

    assert_select "form[action=?][method=?]", globalnotifications_path, "post" do

      assert_select "textarea#globalnotification_body[name=?]", "globalnotification[body]"

      assert_select "input#globalnotification_visibility[name=?]", "globalnotification[visibility]"
    end
  end
end
