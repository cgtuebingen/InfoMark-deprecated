require 'rails_helper'

RSpec.describe "globalnotifications/show", type: :view do
  before(:each) do
    @globalnotification = assign(:globalnotification, Globalnotification.create!(
      :body => "MyText",
      :visibility => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/1/)
  end
end
