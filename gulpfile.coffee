
# Basic gulp stuff
gulp    = require 'gulp'
gutil   = require 'gulp-util'

# Bourbon & Neat
neat    = require('node-neat').includePaths
paths = scss: "./assets/stylesheets/**/*.scss"

# Plugins
coffee  = require 'gulp-coffee'
concat  = require 'gulp-concat'
uglify  = require 'gulp-uglify'
sass    = require 'gulp-sass'
refresh = require 'gulp-livereload'

# Styles
# --------------------------------------------------
gulp.task 'styles', ->
  gulp.src('assets/stylesheets/src/application.scss')
    .pipe(sass(includePaths: ['styles'].concat(neat)))
    .pipe(concat 'application.css')
    .pipe(gulp.dest 'assets/stylesheets')
