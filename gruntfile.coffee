module.exports = (grunt) ->

  # Project configuration
  grunt.initConfig

    autoprefixer:
      dist:
        options:
          browsers: ['last 2 versions', '> 5%', 'Firefox ESR']
        src: 'assets/styles/admin.min.css'

    notify:
      sass:
        options:
          title: "Task Complete"
          message: "SASS finished compiling!"

    sass:
      dist:
        files: ['assets/styles/admin.min.css': 'assets/styles/source/admin.scss']
        options:
          style: 'compressed'
          quiet: true
          sourceMap: false

    watch:
      styles:
        files: ['assets/styles/source/**/*.scss']
        tasks: ['sass', 'autoprefixer']
        options:
          livereload: true

  # Load all Grunt tasks automatically
  require('load-grunt-tasks') grunt

  # Register tasks
  grunt.registerTask 'default', ['sass'];

  return
