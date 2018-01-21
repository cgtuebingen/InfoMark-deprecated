require 'rails_helper'

RSpec.describe "supplementaries/new", type: :view do
  before(:each) do
    assign(:supplementary, Supplementary.new(
      :file => "MyString",
      :course => nil,
      :info => "MyString"
    ))
  end

  it "renders new supplementary form" do
    render

    assert_select "form[action=?][method=?]", supplementaries_path, "post" do

      assert_select "input#supplementary_file[name=?]", "supplementary[file]"

      assert_select "input#supplementary_course_id[name=?]", "supplementary[course_id]"

      assert_select "input#supplementary_info[name=?]", "supplementary[info]"
    end
  end
end
