require 'rails_helper'

RSpec.describe "Globalnotifications", type: :request do
  describe "GET /globalnotifications" do
    it "works! (now write some real specs)" do
      get globalnotifications_path
      expect(response).to have_http_status(200)
    end
  end
end
