gulp 	 = require 'gulp'
clean  = require 'gulp-clean'
concat = require 'gulp-concat'
rename = require 'gulp-rename'
stylus = require 'gulp-stylus'
notify = require 'gulp-notify'

gulp.task 'clean-dev', ->
	gulp.src './public/build-dev'
		.pipe do clean


gulp.task 'newsletter.stylus', ->
	gulp.src './public/layout/newsletter/stylus/*.styl'
		.pipe do stylus
		.on 'error', notify.onError 'Error: <%= error.message %>'
		.pipe concat 'newsletter.css'
		.pipe gulp.dest './public/build-dev/layout/newsletter'
		return

gulp.task 'stylus', ['newsletter.stylus']

gulp.task 'watch', ['stylus'], ->
	gulp.watch './public/layout/newsletter/stylus/*.styl', ['newsletter.stylus']
