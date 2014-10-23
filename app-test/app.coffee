Gathering = require '../gathering'

Gathering.config.use_dir "#{__dirname}/config"

do Gathering.service.start
