gulp 	 = require 'gulp'
clean  = require 'gulp-clean'
concat = require 'gulp-concat'
rename = require 'gulp-rename'
stylus = require 'gulp-stylus'
notify = require 'gulp-notify'
nib = require 'nib'

# Main tasks

gulp.task 'clean-dev', ->
	gulp.src './public/build-dev'
		.pipe do clean

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


# Article stash tasks

gulp.task 'article_stash.stylus', ->
	gulp.src [
			'./public/layout/article_stash/stylesheets/*.styl'
		]
		.pipe stylus
			use: nib()
		.on 'error', notify.onError 'Error: <%= error.message %>'
		.pipe concat 'style.css'
		.pipe gulp.dest './public/build-dev/layout/article_stash'
		return

gulp.task 'article_stash.html', ->
	gulp.src './public/layout/article_stash/*.html'
		.pipe gulp.dest './public/build-dev/layout/article_stash'
		return


# Grouping tasks

tasks = 
	main: [
		'main.stylus'
	]

	article_stash: [
		'article_stash.stylus'
		'article_stash.html'
	]

all_tasks = []
all_tasks = all_tasks.concat.apply all_tasks, [
	tasks.main
	tasks.article_stash
]

gulp.task 'watch', all_tasks, ->
	gulp.watch './public/common/**/*', tasks.main
	gulp.watch './public/layout/article_stash/**/*', tasks.article_stash
