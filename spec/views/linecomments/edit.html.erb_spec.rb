require 'rails_helper'

RSpec.describe "linecomments/edit", type: :view do
  before(:each) do
    @linecomment = assign(:linecomment, Linecomment.create!(
      :submission => nil,
      :file_name => "MyString",
      :line => 1,
      :comment => "MyString",
      :user => nil
    ))
  end

  it "renders the edit linecomment form" do
    render

    assert_select "form[action=?][method=?]", linecomment_path(@linecomment), "post" do

      assert_select "input#linecomment_submission_id[name=?]", "linecomment[submission_id]"

      assert_select "input#linecomment_file_name[name=?]", "linecomment[file_name]"

      assert_select "input#linecomment_line[name=?]", "linecomment[line]"

      assert_select "input#linecomment_comment[name=?]", "linecomment[comment]"

      assert_select "input#linecomment_user_id[name=?]", "linecomment[user_id]"
    end
  end
end
