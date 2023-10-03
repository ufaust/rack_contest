require 'rack'
require 'rack/server'
require_relative 'app/api'

Rack::Server.start(app: APP)