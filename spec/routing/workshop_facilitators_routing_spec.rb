# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WorkshopFacilitatorsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/workshop_facilitators').to route_to('workshop_facilitators#index')
    end

    it 'routes to #new' do
      expect(get: '/workshop_facilitators/new').to route_to('workshop_facilitators#new')
    end

    it 'routes to #show' do
      expect(get: '/workshop_facilitators/1').to route_to('workshop_facilitators#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/workshop_facilitators/1/edit').to route_to('workshop_facilitators#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/workshop_facilitators').to route_to('workshop_facilitators#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/workshop_facilitators/1').to route_to('workshop_facilitators#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/workshop_facilitators/1').to route_to('workshop_facilitators#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/workshop_facilitators/1').to route_to('workshop_facilitators#destroy', id: '1')
    end
  end
end
