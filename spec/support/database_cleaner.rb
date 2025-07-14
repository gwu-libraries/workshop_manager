# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation, except: %w[ar_internal_metadata]
  end

  config.before { DatabaseCleaner.strategy = :transaction }

  config.before { DatabaseCleaner.start }

  config.after { DatabaseCleaner.clean }
end
