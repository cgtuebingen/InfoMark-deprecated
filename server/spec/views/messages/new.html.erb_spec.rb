require 'rails_helper'

RSpec.describe "messages/new", type: :view do
  before(:each) do
    assign(:message, Message.new(
      :recipients => "MyText",
      :subject => "MyText",
      :body => "MyText"
    ))
  end

  it "renders new message form" do
    render

    assert_select "form[action=?][method=?]", messages_path, "post" do

      assert_select "textarea#message_recipients[name=?]", "message[recipients]"

      assert_select "textarea#message_subject[name=?]", "message[subject]"

      assert_select "textarea#message_body[name=?]", "message[body]"
    end
  end
end
