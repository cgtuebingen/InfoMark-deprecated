require 'rails_helper'

RSpec.describe "ExamGrades", type: :request do
  describe "GET /exam_grades" do
    it "works! (now write some real specs)" do
      get exam_grades_path
      expect(response).to have_http_status(200)
    end
  end
end
