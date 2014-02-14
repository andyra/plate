module.exports = function(grunt) {

  // Project configuration
  grunt.initConfig({
    sass: {
      dist: {
        files: {
          "assets/stylesheets/styles.min.css" : "assets/stylesheets/source/styles.scss"
        },
        options: {
          style: "compressed",
          sourceMap: false
        }
      }
    },
  })

  // Load tasks
  grunt.loadNpmTasks("grunt-contrib-sass");
  grunt.loadNpmTasks('grunt-contrib-watch');
};
