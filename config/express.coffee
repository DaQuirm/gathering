express = require 'express'

module.exports = (app) ->
	app.use '/apps/', express.static "#{__dirname}/../public"
