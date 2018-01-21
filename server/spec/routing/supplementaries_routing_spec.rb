require "rails_helper"

RSpec.describe SupplementariesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/supplementaries").to route_to("supplementaries#index")
    end

    it "routes to #new" do
      expect(:get => "/supplementaries/new").to route_to("supplementaries#new")
    end

    it "routes to #show" do
      expect(:get => "/supplementaries/1").to route_to("supplementaries#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/supplementaries/1/edit").to route_to("supplementaries#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/supplementaries").to route_to("supplementaries#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/supplementaries/1").to route_to("supplementaries#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/supplementaries/1").to route_to("supplementaries#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/supplementaries/1").to route_to("supplementaries#destroy", :id => "1")
    end

  end
end
