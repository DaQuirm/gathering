gulp 	 = require 'gulp'
clean  = require 'gulp-clean'
concat = require 'gulp-concat'
rename = require 'gulp-rename'
stylus = require 'gulp-stylus'
notify = require 'gulp-notify'
nib = require 'nib'

gulp.task 'clean-dev', ->
	gulp.src './public/build-dev'
		.pipe do clean


gulp.task 'newsletter-layout.stylus', ->
	gulp.src [
			'./public/layout/newsletter/stylesheets/*.styl'
		]
		.pipe stylus
			use: nib()
		.on 'error', notify.onError 'Error: <%= error.message %>'
		.pipe concat 'newsletter.css'
		.pipe gulp.dest './public/build-dev/layout/newsletter'
		return

gulp.task 'copy', ->
	gulp.src './public/layout/newsletter/*.html'
		.pipe gulp.dest './public/build-dev/layout/newsletter'
		return


gulp.task 'watch', ['newsletter-layout.stylus', 'copy'], ->
	gulp.watch './public/layout/newsletter/stylesheets/*.styl', ['newsletter-layout.stylus']
	gulp.watch './public/layout/newsletter/*.html', ['copy']
