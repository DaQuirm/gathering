module.exports = (grunt) ->
 grunt.loadNpmTasks 'grunt-contrib-clean'
 grunt.loadNpmTasks 'grunt-contrib-coffee'
 grunt.loadNpmTasks 'grunt-coffeelint'

 grunt.initConfig
  clean:
   server:
    src: ['build/']

  coffeelint:
   server:
    src:
     ['Gruntfile.coffee','service.coffee','app/**/*.coffee','config/**/*.coffee']
   options:
    'no_tabs':
     'level': 'ignore'
    'indentation':
     'level': 'ignore'
    'max_line_length':
     'level': 'ignore'

  coffee:
   server:
    expand: true
    ext: '.js'
    src: ['app/**/*.coffee', 'config/**/*.coffee', 'service.coffee']
    dest: 'build/'
    options:
     bare: true

 grunt.registerTask 'default', ['clean', 'coffeelint', 'coffee']

