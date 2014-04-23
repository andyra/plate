# To add the clean script back in, follow the instructions here:
# http://markgoodyear.com/2014/01/getting-started-with-gulp/

# Load plugins
gulp          = require 'gulp'
sass          = require 'gulp-ruby-sass'
autoprefixer  = require 'gulp-autoprefixer'
minifycss     = require 'gulp-minify-css'
jshint        = require 'gulp-jshint'
uglify        = require 'gulp-uglify'
imagemin      = require 'gulp-imagemin'
rename        = require 'gulp-rename'
clean         = require 'gulp-clean'
concat        = require 'gulp-concat'
notify        = require 'gulp-notify'
cache         = require 'gulp-cache'
livereload    = require 'gulp-livereload'
lr            = require 'tiny-lr'
server        = lr()

# Styles
gulp.task 'styles', ->
  gulp.src 'assets/styles/src/*.scss'
    .pipe rubySass(style: 'expanded')
    .pipe autoprefixer('last 2 version', 'safari 5', 'ie 8', 'ie 9', 'opera 12.1', 'ios 6', 'android 4')
    .pipe minifyCss()
    .pipe rename(suffix: '.min')
    .pipe gulp.dest('assets/styles')
    .pipe livereload(server)
    .pipe notify(message: 'Styles task complete')

# Scripts
gulp.task 'scripts', ->
  gulp.src 'assets/scripts/src/*.js'
    .pipe jshint('.jshintrc')
    .pipe jshint.reporter('default')
    .pipe concat('application.js')
    .pipe uglify()
    .pipe rename(suffix: '.min')
    .pipe gulp.dest('assets/scripts')
    .pipe livereload(server)
    .pipe notify(message: 'Scripts task complete')

# Images
gulp.task 'images', ->
  gulp.src 'assets/images/**/*'
    .pipe(cache(imagemin(
      optimizationLevel: 3
      progressive: true
      interlaced: true
    )))
    .pipe livereload(server)
    .pipe gulp.dest('assets/images')
    .pipe notify(message: 'Images task complete')

# Watch on port 35729 for styles, scripts, and images
gulp.task 'watch', ->
  server.listen 35729, (err) ->
    return console.log(err)  if err
    gulp.watch 'assets/styles/**/*.scss', ['styles']
    gulp.watch 'assets/scripts/**/*.js', ['scripts']
    gulp.watch 'assets/images/**/*', ['images']
    return
  return
