require "rails_helper"

RSpec.describe LinecommentsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/linecomments").to route_to("linecomments#index")
    end

    it "routes to #new" do
      expect(:get => "/linecomments/new").to route_to("linecomments#new")
    end

    it "routes to #show" do
      expect(:get => "/linecomments/1").to route_to("linecomments#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/linecomments/1/edit").to route_to("linecomments#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/linecomments").to route_to("linecomments#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/linecomments/1").to route_to("linecomments#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/linecomments/1").to route_to("linecomments#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/linecomments/1").to route_to("linecomments#destroy", :id => "1")
    end

  end
end
