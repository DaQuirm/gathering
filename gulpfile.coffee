gulp 	 = require 'gulp'
clean  = require 'gulp-clean'
concat = require 'gulp-concat'
rename = require 'gulp-rename'
coffee = require 'gulp-coffee'
stylus = require 'gulp-stylus'
notify = require 'gulp-notify'

gulp.task 'clean-dev', ->
	gulp.src './public/build-dev'
		.pipe do clean

gulp.task 'events-proto.coffee', ->
	gulp.src [

		# Nexus extensions
		'./public/nexus-extensions/input.coffee'

		# Application
		'./public/events-proto/src/app.coffee'

		# Models
		'./public/events-proto/src/models/break.coffee'
		'./public/events-proto/src/models/talk.coffee'
		'./public/events-proto/src/models/slot.coffee'
		'./public/events-proto/src/models/talk-collection.coffee'
		'./public/events-proto/src/models/event.coffee'
		'./public/events-proto/src/models/event-collection.coffee'

		# ViewModels
		'./public/events-proto/src/viewmodels/event-viewmodel.coffee'
		'./public/events-proto/src/viewmodels/app-viewmodel.coffee'

		# Views
		'./public/events-proto/src/views/talk-form-view.coffee'
		'./public/events-proto/src/views/break-form-view.coffee'
		'./public/events-proto/src/views/slot-form-view.coffee'
		'./public/events-proto/src/views/slot-view.coffee'
		'./public/events-proto/src/views/event-form-view.coffee'
		'./public/events-proto/src/views/event-view.coffee'
		'./public/events-proto/src/views/app-view.coffee'

		]
		.pipe do coffee
		.on 'error', notify.onError 'Error: <%= error.message %>'
		.pipe concat 'events-proto.js'
		.pipe gulp.dest './public/build-dev/events-proto'
		return

gulp.task 'events-proto.stylus', ->
	gulp.src './public/events-proto/stylesheets/*.styl'
		.pipe do stylus
		.on 'error', notify.onError 'Error: <%= error.message %>'
		.pipe concat 'events-proto.css'
		.pipe gulp.dest './public/build-dev/events-proto'
		return

gulp.task 'coffee', ['events-proto.coffee']
gulp.task 'stylus', ['events-proto.stylus']

gulp.task 'watch', ['coffee', 'stylus'], ->
	gulp.watch './public/events-proto/src/**/*.coffee', ['events-proto.coffee']
	gulp.watch './public/events-proto/stylesheets/*.styl', ['events-proto.stylus']
