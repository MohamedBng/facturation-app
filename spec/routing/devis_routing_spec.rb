require "rails_helper"

RSpec.describe DevisController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/devis").to route_to("devis#index")
    end

    it "routes to #new" do
      expect(get: "/devis/new").to route_to("devis#new")
    end

    it "routes to #show" do
      expect(get: "/devis/1").to route_to("devis#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/devis/1/edit").to route_to("devis#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/devis").to route_to("devis#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/devis/1").to route_to("devis#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/devis/1").to route_to("devis#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/devis/1").to route_to("devis#destroy", id: "1")
    end
  end
end
