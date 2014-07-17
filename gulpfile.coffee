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


tasks = [
	'main.stylus'
	'article_stash.stylus'
	'article_stash.html'
]

gulp.task 'watch', tasks, ->
	gulp.watch './public/**/*', tasks
