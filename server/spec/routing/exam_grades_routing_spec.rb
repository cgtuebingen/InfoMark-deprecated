require "rails_helper"

RSpec.describe ExamGradesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/exam_grades").to route_to("exam_grades#index")
    end

    it "routes to #new" do
      expect(:get => "/exam_grades/new").to route_to("exam_grades#new")
    end

    it "routes to #show" do
      expect(:get => "/exam_grades/1").to route_to("exam_grades#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/exam_grades/1/edit").to route_to("exam_grades#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/exam_grades").to route_to("exam_grades#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/exam_grades/1").to route_to("exam_grades#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/exam_grades/1").to route_to("exam_grades#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/exam_grades/1").to route_to("exam_grades#destroy", :id => "1")
    end

  end
end
