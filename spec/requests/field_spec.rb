require 'rails_helper'

RSpec.describe "Fields", type: :request do
  describe "GET /index" do
    it "renders a successfull response" do
      get fields_path

      expect(response).to be_successful
    end
  end
end
