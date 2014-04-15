# http://markgoodyear.com/2014/01/getting-started-with-gulp/

# Load plugins
gulp    = require 'gulp'
gp      = do require 'gulp-load-plugins'  # Load all gulp plugins
lr      = require 'tiny-lr'
server  = lr()

# Styles
gulp.task 'styles', ->
  gulp.src 'assets/stylesheets/src/*.scss'
    .pipe gp.rubySass(style: 'expanded')
    .pipe gp.autoprefixer('last 2 version', 'safari 5', 'ie 8', 'ie 9', 'opera 12.1', 'ios 6', 'android 4')
    .pipe gulp.dest('dist/styles')
    .pipe gp.rename(suffix: '.min')
    .pipe gp.minifyCss()
    .pipe gp.livereload(server)
    .pipe gulp.dest('dist/styles')
    .pipe gp.notify(message: 'Styles task complete')

# Scripts
gulp.task 'scripts', ->
  gulp.src 'assets/javascripts/src/*.js'
    .pipe gp.jshint('.jshintrc')
    .pipe gp.jshint.reporter('default')
    .pipe gp.concat('main.js')
    .pipe gulp.dest('dist/scripts')
    .pipe gp.rename(suffix: '.min')
    .pipe gp.uglify()
    .pipe gp.livereload(server)
    .pipe gulp.dest('dist/scripts')
    .pipe gp.notify(message: 'Scripts task complete')

# Images
gulp.task 'images', ->
  gulp.src 'assets/images/**/*'
    .pipe(gp.cache(gp.imagemin(
      optimizationLevel: 3
      progressive: true
      interlaced: true
    )))
    .pipe gp.livereload(server)
    .pipe gulp.dest('dist/images')
    .pipe gp.notify(message: 'Images task complete')

# Clean
gulp.task 'clean', ->
  gulp.src ['dist/styles', 'dist/scripts', 'dist/images'], read: false
  .pipe gp.clean()

# Default task
gulp.task 'default', ['clean'], ->
  gulp.start 'styles', 'scripts', 'images'
  return

# Watch on port 35729 for styles, scripts, and images
gulp.task 'watch', ->
  server.listen 35729, (err) ->
    return console.log(err)  if err
    gulp.watch 'assets/stylesheets/**/*.scss', ['styles']
    gulp.watch 'assets/javascripts/**/*.js', ['scripts']
    gulp.watch 'assets/images/**/*', ['images']
    return
  return
