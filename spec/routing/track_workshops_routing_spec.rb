require "rails_helper"

RSpec.describe TrackWorkshopsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/track_workshops").to route_to("track_workshops#index")
    end

    it "routes to #new" do
      expect(get: "/track_workshops/new").to route_to("track_workshops#new")
    end

    it "routes to #show" do
      expect(get: "/track_workshops/1").to route_to("track_workshops#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/track_workshops/1/edit").to route_to("track_workshops#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/track_workshops").to route_to("track_workshops#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/track_workshops/1").to route_to("track_workshops#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/track_workshops/1").to route_to("track_workshops#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/track_workshops/1").to route_to("track_workshops#destroy", id: "1")
    end
  end
end
