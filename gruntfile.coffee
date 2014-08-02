module.exports = (grunt) ->

  # Project configuration
  grunt.initConfig

    concat:
      options:
        separator: ';'
        stripBanners: true
      dist:
        src: [
          # Manual dependency ordering (put specific files first)
          'assets/javascripts/src/*.js'
          'assets/javascripts/src/application.js'
        ]
        dest: 'assets/javascripts/application.min.js'

    uglify:
      dist:
        src: '<%= concat.dist.dest %>'
        dest: '<%= concat.dist.dest %>' # Stomp over the file

    jshint:
      options:
        curly: true
        eqeqeq: true
        immed: true
        latedef: true
        newcap: true
        noarg: true
        sub: true
        undef: true
        unused: true
        boss: true
        eqnull: true
        browser: true
        globals: {}

    autoprefixer:
      dist:
        options:
          browsers: ['last 2 versions', '> 5%', 'Firefox ESR']
        src: 'assets/stylesheets/application.min.css'

    notify:
      sass:
        options:
          title: "Task Complete"
          message: "SASS finished compiling!"

    sass:
      dist:
        files: ['assets/stylesheets/application.min.css': 'assets/stylesheets/source/application.scss']
        options:
          style: 'compressed'
          quiet: true
          sourceMap: false

    watch:
      options:
        livereload: true
      stylesheets:
        files: ['assets/stylesheets/**/*.scss']
        tasks: ['sass', 'autoprefixer']
      javascripts:
        files: ['assets/javascripts/src/*.js']
        tasks: ['jshint', 'concat', 'uglify']

    webfont:
      icons:
        src: 'assets/fonts/src/*.svg'
        dest: 'assets/fonts/icons'
        destCss: 'assets/stylesheets/src/shared'
        options:
          font: 'icons'
          hashes: true
          htmlDemo: false
          templateOptions:
            baseClass: 'icon',
            classPrefix: 'icon-',
          stylesheet: 'scss'
          relativeFontPath: '../fonts/icons'

  # Load all Grunt tasks automatically
  require('load-grunt-tasks') grunt

  # Register tasks
  grunt.registerTask 'default', ['jshint', 'concat', 'uglify', 'sass', 'autoprefixer']
  grunt.registerTask 'scripts', ['jshint', 'concat', 'uglify']
  grunt.registerTask 'styles', ['sass', 'autoprefixer']
  grunt.registerTask 'icons', ['webfont']

  return
