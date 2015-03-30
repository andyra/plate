var gulp          = require('gulp');
var es            = require('event-stream');
var gutil         = require('gulp-util');
var sourcemaps    = require('gulp-sourcemaps');
var addsrc        = require('gulp-add-src')
var order         = require('gulp-order');
var header        = require('gulp-header');
var rename        = require('gulp-rename');
var print         = require('gulp-print');

var sass          = require('gulp-sass');
var autoprefixer  = require('gulp-autoprefixer');
var minifyCSS     = require('gulp-minify-css');

var coffee        = require('gulp-coffee');
var concat        = require('gulp-concat');
var uglify        = require('gulp-uglify');
var jshint        = require('gulp-jshint');

var svgstore      = require('gulp-svgstore');
var svgmin        = require('gulp-svgmin');
var imagemin      = require('gulp-imagemin');
var pngquant      = require('imagemin-pngquant');

var browserSync   = require('browser-sync');

var pkg           = require('./package.json');

// Config
// ----------------------------------------------------------------------------

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

var paths = {
  images: {
    src: 'src/images/',
    dest: 'dist/images/'
  },
  scripts: {
    src: 'src/javascripts/',
    dest: 'dist/javascripts/'
  },
  styles: {
    src: 'src/stylesheets/',
    dest: 'dist/stylesheets/'
  },
  sprite: {
    src: 'src/images/sprite/'
  }
};

//  Tasks
// ----------------------------------------------------------------------------

// Stylesheets
gulp.task('styles', function() {
  gulp.src(paths.styles.src + 'plate.scss')
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
    .pipe(gulp.dest(paths.styles.dest))
    .pipe(browserSync.reload({
      stream: true
    }));
});

// JavaScripts
gulp.task('scripts',function(){
  gulp.src(paths.scripts.src + '**/*.coffee')
    .pipe(coffee())
    .pipe(addsrc(paths.scripts.src + '**/*.js'))
    .pipe(order([
      paths.scripts.src + 'vendor/*.js',
      paths.scripts.src + 'shared/*.js',
      paths.scripts.src + 'pages/*.js'
    ], {base: '.'}))
    .pipe(jshint('.jshintrc')) // lint them
    .pipe(jshint.reporter('default'))
    .pipe(concat('plate.js'))
    .pipe(uglify())
    .pipe(header(banner, { pkg : pkg }))
    .pipe(rename({ suffix: '.min' }))
    .pipe(gulp.dest(paths.scripts.dest))
    .pipe(browserSync.reload({
      stream:true,
      once: true
    }));
});

// SVG Sprite
gulp.task('sprite', function () {
  gulp.src(paths.images.src + 'sprite/**/*.svg')
    .pipe(svgstore())
    .pipe(gulp.dest(paths.images.src));
});

// Images
gulp.task('images', function () {
  return gulp.src(paths.images.src + '*.{png,jpg,jpeg,gif,svg}')
    .pipe(imagemin({
      progressive: true,
      svgoPlugins: [{
        removeViewBox: false
      }],
      use: [pngquant()]
    }))
    .pipe(gulp.dest(paths.images.dest));
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
