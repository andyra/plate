# http://markgoodyear.com/2014/01/getting-started-with-gulp/

# Load plugins
gulp    = require 'gulp'
gp      = do require 'gulp-load-plugins'  # Load all gulp plugins
lr      = require 'tiny-lr'
server  = lr()

# Styles
gulp.task 'styles', ->
  gulp.src 'assets/styles/src/*.scss'
    .pipe gp.rubySass(style: 'expanded')
    .pipe gp.autoprefixer('last 2 version', 'safari 5', 'ie 8', 'ie 9', 'opera 12.1', 'ios 6', 'android 4')
    .pipe gp.minifyCss()
    .pipe gp.rename(suffix: '.min')
    .pipe gulp.dest('assets/styles')
    .pipe gp.livereload(server)
    .pipe gp.notify(message: 'Styles task complete')

# Scripts
gulp.task 'scripts', ->
  gulp.src 'assets/scripts/src/*.js'
    .pipe gp.jshint('.jshintrc')
    .pipe gp.jshint.reporter('default')
    .pipe gp.concat('application.js')
    .pipe gp.uglify()
    .pipe gp.rename(suffix: '.min')
    .pipe gulp.dest('assets/scripts')
    .pipe gp.livereload(server)
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
    .pipe gulp.dest('assets/images')
    .pipe gp.notify(message: 'Images task complete')

# Clean
# gulp.task 'clean', ->
#   gulp.src ['assets/styles', 'assets/scripts', 'assets/images'], read: false
#   .pipe gp.clean()

# # Default task
# gulp.task 'default', ['clean'], ->
#   gulp.start 'styles', 'scripts', 'images'
#   return

# Watch on port 35729 for styles, scripts, and images
gulp.task 'watch', ->
  server.listen 35729, (err) ->
    return console.log(err)  if err
    gulp.watch 'assets/styles/**/*.scss', ['styles']
    gulp.watch 'assets/scripts/**/*.js', ['scripts']
    gulp.watch 'assets/images/**/*', ['images']
    return
  return
