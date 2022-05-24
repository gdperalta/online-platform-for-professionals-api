require 'rails_helper'
require 'rest-client'

RSpec.describe "Locations", type: :request do
  
  describe "GET /cities" do
    it "renders a successful response" do
      get '/cities'
      expect(response).to be_successful
    end
  end

  describe "GET /regions" do
    it "renders a successful response" do
      get '/regions'
      expect(response).to be_successful
    end
  end
end
