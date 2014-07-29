gulp 	 = require 'gulp'
rimraf  = require 'gulp-rimraf'
concat = require 'gulp-concat'
rename = require 'gulp-rename'
stylus = require 'gulp-stylus'
coffee = require 'gulp-coffee'
notify = require 'gulp-notify'
nib = require 'nib'

copy_html = (folder) ->
	gulp.task "#{folder}.html", ->
		gulp.src [
			"./public/layout/#{folder}/*.html"
		]
		.pipe gulp.dest "./public/build-dev/layout/#{folder}/"
		return
	return "#{folder}.html"

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

# Userpic generator

gulp.task 'userpic.coffee', ->
	gulp.src [
		'./public/layout/userpic/src/*.coffee'
	]
	.pipe coffee
		bare: yes
	.on 'error', notify.onError 'Error: <%= error.message %>'
	.pipe gulp.dest './public/build-dev/layout/userpic/src/'
	return

# Grouping tasks

tasks =
	main: [
		'main.stylus'
	]
	userpic: [
		copy_html 'userpic'
		'userpic.coffee'
	]


all_tasks = []
all_tasks = all_tasks.concat.apply all_tasks, [
	tasks.main
	tasks.userpic
]

gulp.task 'watch', all_tasks, ->
	gulp.watch './public/common/**/*', tasks.main
	gulp.watch './public/layout/userpic/**/*', tasks.userpic
