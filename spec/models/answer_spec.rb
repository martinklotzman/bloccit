require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:question) { Question.create!(title: "New Question Title", body: "New Question Body", resolved: false) }
  let(:answer) { Answer.create!(question: question, body: "New Answer Body") }

  describe "attributes" do
    it "has a body attribute" do
      expect(answer).to have_attributes(body: "New Answer Body")
    end
  end
end
