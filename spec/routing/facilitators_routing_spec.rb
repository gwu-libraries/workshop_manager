require "rails_helper"

RSpec.describe FacilitatorsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/facilitators").to route_to("facilitators#index")
    end

    it "routes to #new" do
      expect(get: "/facilitators/new").to route_to("facilitators#new")
    end

    it "routes to #show" do
      expect(get: "/facilitators/1").to route_to("facilitators#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/facilitators/1/edit").to route_to("facilitators#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/facilitators").to route_to("facilitators#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/facilitators/1").to route_to("facilitators#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/facilitators/1").to route_to("facilitators#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/facilitators/1").to route_to("facilitators#destroy", id: "1")
    end
  end
end
