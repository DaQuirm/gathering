# Configuration
require './config/config'

# Gathering API
config  = require './config/config'
service = require './service/service'

module.exports =
	# Configuration
	config:  config
	# Express service application
	service: service

