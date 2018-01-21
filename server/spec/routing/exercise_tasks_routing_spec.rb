require "rails_helper"

RSpec.describe ExerciseTasksController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/exercise_tasks").to route_to("exercise_tasks#index")
    end

    it "routes to #new" do
      expect(:get => "/exercise_tasks/new").to route_to("exercise_tasks#new")
    end

    it "routes to #show" do
      expect(:get => "/exercise_tasks/1").to route_to("exercise_tasks#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/exercise_tasks/1/edit").to route_to("exercise_tasks#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/exercise_tasks").to route_to("exercise_tasks#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/exercise_tasks/1").to route_to("exercise_tasks#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/exercise_tasks/1").to route_to("exercise_tasks#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/exercise_tasks/1").to route_to("exercise_tasks#destroy", :id => "1")
    end

  end
end
