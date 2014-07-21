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

gulp.task 'main.stylus', ->
	gulp.src [
		'./public/common/global.styl'
	]
	.pipe stylus
		use: nib()
	.on 'error', notify.onError 'Error: <%= error.message %>'
	.pipe concat 'main.css'
	.pipe gulp.dest './public/build-dev/common/'
	return

# Auth tasks

gulp.task 'auth.stylus', ->
	gulp.src [
		'./public/layout/auth/stylesheets/*.styl'
	]
	.pipe stylus
		use: do nib
	.on 'error', notify.onError 'Error: <%= error.message %>'
	.pipe concat 'style.css'
	.pipe gulp.dest './public/build-dev/layout/auth/'
	return

gulp.task 'auth.html', ->
	gulp.src [
		'./public/layout/auth/*.html'
	]
	.pipe gulp.dest './public/build-dev/layout/auth/'
	return

# Grouping tasks

tasks = 
	main: [
		'main.stylus'
	]
	auth: [
		'auth.html'
		'auth.stylus'
	]

all_tasks = []
all_tasks = all_tasks.concat.apply all_tasks, [
	tasks.main
	tasks.auth
]

gulp.task 'watch', all_tasks, ->
	gulp.watch './public/common/**/*', tasks.main
	gulp.watch './public/layout/auth/*.html', ['auth.html']
	gulp.watch './public/layout/auth/stylesheets/*.styl', ['auth.stylus']

