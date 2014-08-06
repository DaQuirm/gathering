gulp   = require 'gulp'
rimraf = require 'gulp-rimraf'
concat = require 'gulp-concat'
rename = require 'gulp-rename'
stylus = require 'gulp-stylus'
notify = require 'gulp-notify'
nib    = require 'nib'
coffee = require 'gulp-coffee'

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


# Article stash tasks

gulp.task 'article-stash.stylus', ->
	gulp.src [
			'./public/layout/article-stash/stylesheets/*.styl'
		]
		.pipe stylus
			use: nib()
		.on 'error', notify.onError 'Error: <%= error.message %>'
		.pipe concat 'style.css'
		.pipe gulp.dest './public/build-dev/layout/article-stash'
		return

gulp.task 'article-stash.html', ->
	gulp.src './public/layout/article-stash/*.html'
		.pipe gulp.dest './public/build-dev/layout/article-stash'
		return

gulp.task 'article_stash.coffee', ->
	gulp.src [

		# Application
		'./public/article-stash/src/app.coffee'

		# Models
		'./public/article-stash/src/models/article.coffee'
		'./public/article-stash/src/models/article-collection.coffee'

		# ViewModels
		'./public/article-stash/src/viewmodels/articles-viewmodel.coffee'
		'./public/article-stash/src/viewmodels/app-viewmodel.coffee'

		# Views
		'./public/article-stash/src/views/digest-view.coffee'
		'./public/article-stash/src/views/articles-view.coffee'
		'./public/article-stash/src/views/app-view.coffee'

		]
		.pipe do coffee
		.on 'error', notify.onError 'Error: <%= error.message %>'
		.pipe concat 'article-stash.js'
		.pipe gulp.dest './public/build-dev/article-stash'
		return


# Grouping tasks

tasks =
	main: [
		'main.stylus'
	]

	article_stash: [
		'article-stash.stylus'
		'article-stash.html'
	]

spa =
	article_stash: [
		'article_stash.coffee'
	]

all_tasks = []
all_tasks = all_tasks.concat.apply all_tasks, [
	tasks.main
	tasks.article_stash
	spa.article_stash
]

gulp.task 'watch', all_tasks, ->
	gulp.watch './public/common/**/*', tasks.main.concat(tasks.article_stash)
	gulp.watch './public/layout/article-stash/**/*', tasks.article_stash
	gulp.watch './public/article-stash/**/*', spa.article_stash
