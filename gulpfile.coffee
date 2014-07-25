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

# User preferences tasks

gulp.task 'prefs.stylus', ->
	gulp.src [
		'./public/layout/prefs/stylesheets/*.styl'
	]
	.pipe stylus
		use: nib()
	.on 'error', notify.onError 'Error: <%= error.message %>'
	.pipe concat 'style.css'
	.pipe gulp.dest './public/build-dev/layout/prefs/'
	return

gulp.task 'prefs.html', ->
	gulp.src './public/layout/prefs/*.html'
	.pipe gulp.dest './public/build-dev/layout/prefs/'
# Grouping tasks

tasks =
	main: [
		'main.stylus'
	]
	prefs: [
		'prefs.stylus'
		'prefs.html'
	]

all_tasks = []
all_tasks = all_tasks.concat.apply all_tasks, [
	tasks.main
	tasks.prefs
]

gulp.task 'watch', all_tasks, ->
	gulp.watch './public/common/**/*', tasks.main.concat tasks.prefs
	gulp.watch './public/layout/prefs/**/*', tasks.prefs
