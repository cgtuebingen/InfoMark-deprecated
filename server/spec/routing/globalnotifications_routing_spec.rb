require "rails_helper"

RSpec.describe GlobalnotificationsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/globalnotifications").to route_to("globalnotifications#index")
    end

    it "routes to #new" do
      expect(:get => "/globalnotifications/new").to route_to("globalnotifications#new")
    end

    it "routes to #show" do
      expect(:get => "/globalnotifications/1").to route_to("globalnotifications#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/globalnotifications/1/edit").to route_to("globalnotifications#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/globalnotifications").to route_to("globalnotifications#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/globalnotifications/1").to route_to("globalnotifications#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/globalnotifications/1").to route_to("globalnotifications#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/globalnotifications/1").to route_to("globalnotifications#destroy", :id => "1")
    end

  end
end
