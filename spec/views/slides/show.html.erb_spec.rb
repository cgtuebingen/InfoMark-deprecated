require 'rails_helper'

RSpec.describe "slides/show", type: :view do
  before(:each) do
    @slide = assign(:slide, Slide.create!(
      :file => "File",
      :course => nil,
      :public => false,
      :info => "Info",
      :title => "Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/File/)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Info/)
    expect(rendered).to match(/Title/)
  end
end
