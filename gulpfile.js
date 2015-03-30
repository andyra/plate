var gulp          = require('gulp');

var sass          = require('gulp-sass');
var autoprefixer  = require('gulp-autoprefixer');
var sourcemaps    = require('gulp-sourcemaps');
var minifyCSS     = require('gulp-minify-css');

var coffee        = require('gulp-coffee');
var order         = require('gulp-order');
var concat        = require('gulp-concat');
var uglify        = require('gulp-uglify');
var jshint        = require('gulp-jshint');

var svgstore      = require('gulp-svgstore');
var svgmin        = require('gulp-svgmin');
var imagemin      = require('gulp-imagemin');
var pngquant      = require('imagemin-pngquant');

var browserSync   = require('browser-sync');
var header        = require('gulp-header');
var rename        = require('gulp-rename');
var print = require('gulp-print');
var addsrc = require('gulp-add-src')

var pkg           = require('./package.json');

//  Setup
// ----------------------------------------------------------------------------

// Banner
var banner = [
  '/*!\n' +
  ' * <%= pkg.title %>\n' +
  ' * <%= pkg.url %>\n' +
  ' * @author <%= pkg.author %>\n' +
  ' * @version <%= pkg.version %>\n' +
  ' * Copyright ' + new Date().getFullYear() + '. <%= pkg.license %> licensed.\n' +
  ' */',
  '\n'
].join('');

//  Tasks
// ----------------------------------------------------------------------------

// Stylesheets
gulp.task('styles', function() {
  gulp.src('src/stylesheets/plate.scss')
    .pipe(sourcemaps.init())
      .pipe(sass({
        errLogToConsole: true,
        includePaths: require('node-neat').includePaths
      }))
    .pipe(autoprefixer('last 2 version'))
    .pipe(minifyCSS())
    .pipe(rename({ suffix: '.min' }))
    .pipe(header(banner, { pkg : pkg }))
    .pipe(sourcemaps.write('.'))
    .pipe(gulp.dest('dist/stylesheets'))
    .pipe(browserSync.reload({ stream: true }));
});

// JavaScripts
gulp.task('scripts',function(){
  gulp.src('src/javascripts/**/*.coffee')
    .pipe(coffee())
    .pipe(addsrc('src/javascripts/**/*.js'))
    .pipe(order([
      'src/javascripts/vendor/*.js',
      'src/javascripts/shared/*.js',
      'src/javascripts/pages/*.js'
    ], {base: '.'}))
    .pipe(jshint('.jshintrc')) // lint them
    .pipe(jshint.reporter('default'))
    .pipe(concat('plate.js'))
    .pipe(uglify())
    .pipe(header(banner, { pkg : pkg }))
    .pipe(rename({ suffix: '.min' }))
    .pipe(gulp.dest('dist/javascripts'))
    .pipe(browserSync.reload({stream:true, once: true}));
});

// SVG Sprite
gulp.task('sprite', function () {
  gulp.src('src/images/sprite/**/*.svg')
    .pipe(svgstore())
    .pipe(gulp.dest('src/images'));
});

// Images
gulp.task('images', function () {
  return gulp.src('src/images/*.{png,jpg,jpeg,gif,svg}')
    .pipe(imagemin({
      progressive: true,
      svgoPlugins: [{
        removeViewBox: false
      }],
      use: [pngquant()]
    }))
    .pipe(gulp.dest('dist/images'));
});

// Server, Watch, Browser
gulp.task('browser-sync', function() {
  browserSync.init(null, {
    server: {
      baseDir: "app"
    }
  });
});

gulp.task('bs-reload', function () {
    browserSync.reload();
});

// Default
gulp.task('default', ['css', 'js', 'browser-sync'], function () {
  gulp.watch("src/scss/*/*.scss", ['css']);
  gulp.watch("src/js/*.js", ['js']);
  gulp.watch("app/*.html", ['bs-reload']);
});
