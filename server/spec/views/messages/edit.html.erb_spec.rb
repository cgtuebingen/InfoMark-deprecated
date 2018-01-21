require 'rails_helper'

RSpec.describe "messages/edit", type: :view do
  before(:each) do
    @message = assign(:message, Message.create!(
      :recipients => "MyText",
      :subject => "MyText",
      :body => "MyText"
    ))
  end

  it "renders the edit message form" do
    render

    assert_select "form[action=?][method=?]", message_path(@message), "post" do

      assert_select "textarea#message_recipients[name=?]", "message[recipients]"

      assert_select "textarea#message_subject[name=?]", "message[subject]"

      assert_select "textarea#message_body[name=?]", "message[body]"
    end
  end
end
