require 'rails_helper'

RSpec.describe "linecomments/show", type: :view do
  before(:each) do
    @linecomment = assign(:linecomment, Linecomment.create!(
      :submission => nil,
      :file_name => "File Name",
      :line => 1,
      :comment => "Comment",
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/File Name/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Comment/)
    expect(rendered).to match(//)
  end
end
