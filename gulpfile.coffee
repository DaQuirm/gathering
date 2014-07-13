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
	gulp.src [
			'./public/layout/newsletter/stylesheets/reset.css'
			'./public/layout/newsletter/stylesheets/*.styl'
		]
		.pipe do stylus
		.on 'error', notify.onError 'Error: <%= error.message %>'
		.pipe concat 'newsletter.css'
		.pipe gulp.dest './public/build-dev/layout/newsletter'
		return

gulp.task 'newsletter.html', ->
	gulp.src './public/layout/newsletter/*.html'
		.pipe gulp.dest './public/build-dev/layout/newsletter'
		return


gulp.task 'watch', ['newsletter.stylus', 'newsletter.html'], ->
	gulp.watch './public/layout/newsletter/stylesheets/*.styl', ['newsletter.stylus']
	gulp.watch './public/layout/newsletter/*.html', ['newsletter.html']
