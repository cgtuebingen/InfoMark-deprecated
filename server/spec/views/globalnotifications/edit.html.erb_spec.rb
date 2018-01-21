require 'rails_helper'

RSpec.describe "globalnotifications/edit", type: :view do
  before(:each) do
    @globalnotification = assign(:globalnotification, Globalnotification.create!(
      :body => "MyText",
      :visibility => 1
    ))
  end

  it "renders the edit globalnotification form" do
    render

    assert_select "form[action=?][method=?]", globalnotification_path(@globalnotification), "post" do

      assert_select "textarea#globalnotification_body[name=?]", "globalnotification[body]"

      assert_select "input#globalnotification_visibility[name=?]", "globalnotification[visibility]"
    end
  end
end
