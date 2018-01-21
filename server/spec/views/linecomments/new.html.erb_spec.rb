require 'rails_helper'

RSpec.describe "linecomments/new", type: :view do
  before(:each) do
    assign(:linecomment, Linecomment.new(
      :submission => nil,
      :file_name => "MyString",
      :line => 1,
      :comment => "MyString",
      :user => nil
    ))
  end

  it "renders new linecomment form" do
    render

    assert_select "form[action=?][method=?]", linecomments_path, "post" do

      assert_select "input#linecomment_submission_id[name=?]", "linecomment[submission_id]"

      assert_select "input#linecomment_file_name[name=?]", "linecomment[file_name]"

      assert_select "input#linecomment_line[name=?]", "linecomment[line]"

      assert_select "input#linecomment_comment[name=?]", "linecomment[comment]"

      assert_select "input#linecomment_user_id[name=?]", "linecomment[user_id]"
    end
  end
end
