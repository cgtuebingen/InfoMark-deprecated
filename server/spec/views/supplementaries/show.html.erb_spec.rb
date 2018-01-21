require 'rails_helper'

RSpec.describe "supplementaries/show", type: :view do
  before(:each) do
    @supplementary = assign(:supplementary, Supplementary.create!(
      :file => "File",
      :course => nil,
      :info => "Info"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/File/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Info/)
  end
end
