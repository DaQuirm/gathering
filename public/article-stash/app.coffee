# Stylesheets
require './stylesheets/style.styl'

# Libs
require '../lib/nexus/build/nexus.js'
require '../nexus-extensions/input.coffee'

# Scripts
AppViewModel = require './src/viewmodels/app-viewmodel'

window.Gathering or= {}
window.Gathering.ArticleStashApp = AppViewModel
