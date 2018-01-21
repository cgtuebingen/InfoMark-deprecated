require 'rails_helper'

RSpec.describe "Linecomments", type: :request do
  describe "GET /linecomments" do
    it "works! (now write some real specs)" do
      get linecomments_path
      expect(response).to have_http_status(200)
    end
  end
end
