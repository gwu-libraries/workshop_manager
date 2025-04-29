# frozen_string_literal: true

RSpec.configure { |config| config.before(:each) { Sidekiq::Worker.clear_all } }
