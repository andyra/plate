module.exports = (grunt) ->

  # Project configuration
  grunt.initConfig

    autoprefixer:
      dist:
        options:
          browsers: ['last 2 versions', '> 5%', 'Firefox ESR']
        src: 'assets/stylesheets/application.min.css'

    notify:
      sass:
        options:
          title: "Task Complete"
          message: "SASS finished compiling!"

    sass:
      dist:
        files: ['assets/stylesheets/application.min.css': 'assets/stylesheets/source/application.scss']
        options:
          style: 'compressed'
          quiet: true
          sourceMap: false

    watch:
      styles:
        files: ['assets/stylesheets/source/**/*.scss']
        tasks: ['sass', 'autoprefixer']
        options:
          livereload: true

  # Load all Grunt tasks automatically
  require('load-grunt-tasks') grunt

  # Register tasks
  grunt.registerTask 'default', ['sass'];

  return
