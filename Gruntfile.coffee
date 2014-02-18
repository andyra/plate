module.exports = (grunt) ->

  # Project configuration
  grunt.initConfig
    sass:
      dist:
        files:
          "assets/stylesheets/styles.min.css": "assets/stylesheets/source/styles.scss"
          "docs/template/public/docs.min.css": "docs/template/assets/docs.scss"
        options:
          style: "compressed"
          sourceMap: false
    styleguide:
      kss:
        options:
          framework:
            name: "kss"
          name: "Proto Style Guide"
          template:
            src: "docs/template"
        files:
          "docs":             "assets/stylesheets/source/*.scss"
          "docs/global":      "assets/stylesheets/source/global/*.scss"
          "docs/base":        "assets/stylesheets/source/base/*.scss"
          "docs/components":  "assets/stylesheets/source/components/*.scss"
    watch:
      sass:
        files: [
          "assets/stylesheets/source/**/*.scss"
          "docs/template/assets/*.scss"
        ]
        tasks: ["sass"]
        options:
          livereload: true


  # Load all Grunt tasks automatically
  require("load-grunt-tasks") grunt
  return
