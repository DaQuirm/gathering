gulp 	 = require 'gulp'
rimraf  = require 'gulp-rimraf'
concat = require 'gulp-concat'
rename = require 'gulp-rename'
stylus = require 'gulp-stylus'
notify = require 'gulp-notify'
nib = require 'nib'


addTasks = (area, html, styl) ->
	htmls = html or ["./public/layout/#{area}/*.html"]
	styls = styl or ["./public/layout/#{area}/stylesheets/*.styl"]

	gulp.task "#{area}.html", ->
		gulp.src htmls
		.pipe gulp.dest "./public/build-dev/layout/#{area}"
		return


	gulp.task "#{area}.styl", ->
		gulp.src styls
		.pipe stylus
			use: nib()
		.on 'error', notify.onError 'Error: <%= error.message %>'
		.pipe concat 'style.css'
		.pipe gulp.dest "./public/build-dev/layout/#{area}"
		return

	return ["#{area}.html", "#{area}.styl"]


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

# Grouping tasks

tasks = 
	main: [
		'main.stylus'
	]
	dashboard: addTasks 'dashboard'

all_tasks = []
all_tasks = all_tasks.concat.apply all_tasks, [
	tasks.main,
	tasks.dashboard
]

gulp.task 'watch', all_tasks, ->
	gulp.watch './public/common/**/*', tasks.main
	gulp.watch './public/layout/dashboard/**/*', tasks.dashboard
