gulp 	 = require 'gulp'
rimraf  = require 'gulp-rimraf'
concat = require 'gulp-concat'
rename = require 'gulp-rename'
stylus = require 'gulp-stylus'
notify = require 'gulp-notify'
nib = require 'nib'

# Main tasks

gulp.task 'clean-dev', ->
	gulp.src './public/build-dev'
		.pipe do rimraf


gulp.task 'newsletter-layout.stylus', ->
	gulp.src [
			'./public/layout/newsletter/stylesheets/reset.css'
			'./public/layout/newsletter/stylesheets/*.styl'
		]
		.pipe do stylus
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
