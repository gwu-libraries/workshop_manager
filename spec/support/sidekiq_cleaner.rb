# frozen_string_literal: true

RSpec.configure { |config| config.before { Sidekiq::Worker.clear_all } }
