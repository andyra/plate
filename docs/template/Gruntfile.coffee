module.exports = (grunt) ->

  # Project configuration
  grunt.initConfig
    sass:
      dist:
        files:
          "assets/stylesheets/docs.min.css": "assets/stylesheets/source/docs.scss"
        options:
          style: "compressed"
          sourceMap: false
    watch:
      sass:
        files: ["assets/stylesheets/source/**/*.scss"]
        tasks: ["sass"]
        options:
          livereload: true

  # Load all Grunt tasks automatically
  require("load-grunt-tasks") grunt
  return
