development:
  host: <%= ENV.fetch('REDIS_HOST', 'localhost') %>
  port: <%= ENV.fetch('REDIS_PORT', '6379') %>
  password: <%= ENV['REDIS_PASSWORD'] %>
test:
  host: <%= ENV.fetch('REDIS_HOST', 'localhost') %>
  port: <%= ENV.fetch('REDIS_PORT', '6379') %>
  password: <%= ENV['REDIS_PASSWORD'] %>
production:
  host: <%= ENV.fetch('REDIS_HOST', 'localhost') %>
  port: <%= ENV.fetch('REDIS_PORT', '6379') %>
  password: <%= ENV['REDIS_PASSWORD'] %>