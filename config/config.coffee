cson  = require 'cson'
path  = require 'path'
nconf = require 'nconf'

cson_format =
	stringify: cson.stringifySync
	parse: cson.parseSync

nconf.defaults
	NODE_ENV: 'development'

do nconf.env

env = nconf.get 'NODE_ENV' # default or from env

module.exports =

	use_dir: (directory) ->
		nconf.file 'environment',
			file: path.join directory, 'envs', "#{env}.cson"
			format: cson_format

		nconf.file 'settings',
			file: path.join directory, 'settings.cson'
			format: cson_format
