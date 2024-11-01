require "rails_helper"

RSpec.describe WorkshopParticipantsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/workshop_participants").to route_to("workshop_participants#index")
    end

    it "routes to #new" do
      expect(get: "/workshop_participants/new").to route_to("workshop_participants#new")
    end

    it "routes to #show" do
      expect(get: "/workshop_participants/1").to route_to("workshop_participants#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/workshop_participants/1/edit").to route_to("workshop_participants#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/workshop_participants").to route_to("workshop_participants#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/workshop_participants/1").to route_to("workshop_participants#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/workshop_participants/1").to route_to("workshop_participants#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/workshop_participants/1").to route_to("workshop_participants#destroy", id: "1")
    end
  end
end
