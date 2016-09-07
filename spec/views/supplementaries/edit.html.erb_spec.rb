require 'rails_helper'

RSpec.describe "supplementaries/edit", type: :view do
  before(:each) do
    @supplementary = assign(:supplementary, Supplementary.create!(
      :file => "MyString",
      :course => nil,
      :info => "MyString"
    ))
  end

  it "renders the edit supplementary form" do
    render

    assert_select "form[action=?][method=?]", supplementary_path(@supplementary), "post" do

      assert_select "input#supplementary_file[name=?]", "supplementary[file]"

      assert_select "input#supplementary_course_id[name=?]", "supplementary[course_id]"

      assert_select "input#supplementary_info[name=?]", "supplementary[info]"
    end
  end
end
