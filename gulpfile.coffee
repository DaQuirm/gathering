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
	gulp.src './public/events-proto/src/**/*.coffee'
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
