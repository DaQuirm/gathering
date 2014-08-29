gulp    = require 'gulp'
util    = require 'gulp-util'
webpack = require 'webpack'

# Plugins
HtmlWebpackPlugin = require 'html-webpack-plugin'

# Creates a standard application bundling task
module.exports = (name, {entry, output, app_class}) ->
	gulp.task name, (done) ->
		config =
			entry: entry
			output:
				path: output
			module:
				loaders: [
					{ test: /\.css$/,    loader: 'css-loader' }
					{ test: /\.coffee$/, loader: 'coffee-loader' }
					{ test: /\.styl$/,   loader: 'style-loader!css-loader!stylus-loader?{"resolve url":true}' }
					# Fonts
					{ test: /\.woff$/,   loader: 'file-loader' }
					{ test: /\.ttf$/,    loader: 'file-loader' }
					{ test: /\.eot$/,    loader: 'file-loader' }
					{ test: /\.svg$/,    loader: 'file-loader' }
				]
			resolve:
				extensions: ['', '.coffee', '.styl']
			devtool: 'source-map'
			plugins: [
				new HtmlWebpackPlugin
					template: './public/common/app-index-template.html'
					data:
						name: name
						app_class: app_class
			]

		compiler = webpack config
		compiler.run (err, stats) ->
			if err then throw new util.PluginError 'webpack', err
			util.log '[webpack]', stats.toString colors:yes
		do done
	name
