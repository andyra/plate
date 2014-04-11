module.exports = (grunt) ->

  # Project configuration
  grunt.initConfig
    autoprefixer:
      dist:
        options:
          browsers: ['last 2 versions', '> 5%', 'Firefox ESR']
        src: 'assets/stylesheets/styles.min.css'
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
      styles:
        files: [
          'assets/stylesheets/src/**/*.scss'
          'docs/source/assets/stylesheets/src/**/*.scss'
        ]
        tasks: ['sass', 'autoprefixer']
        options:
          livereload: true

  # Load all Grunt tasks automatically
  require('load-grunt-tasks') grunt

  # Register tasks
  grunt.registerTask 'default', ['sass'];

  return
