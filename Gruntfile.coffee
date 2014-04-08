module.exports = (grunt) ->

  # Project configuration
  grunt.initConfig
    notify:
      sass:
        options:
          title: "Task Complete"
          message: "SASS finished compiling!"
    sass:
      dist:
        files: [
          'assets/stylesheets/styles.min.css': 'assets/stylesheets/src/styles.scss'
          'docs/source/assets/stylesheets/docs.min.css': 'docs/source/assets/stylesheets/src/docs.scss'
        ]
        options:
          style: 'compressed'
          quiet: true
          sourceMap: false
    watch:
      sass:
        files: [
          'assets/stylesheets/src/**/*.scss'
          'docs/source/assets/stylesheets/src/**/*.scss'
        ]
        tasks: ['sass']
        options:
          livereload: true

  # Load all Grunt tasks automatically
  require('load-grunt-tasks') grunt

  # Register tasks
  grunt.registerTask 'default', ['sass'];

  return
