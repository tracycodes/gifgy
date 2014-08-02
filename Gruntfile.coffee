module.exports = (grunt) ->
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    watch: {
      files: ['./public/**/*.coffee', './public/**/*.scss'],
      tasks: ['coffee', 'scss'],
    },
    coffee: {
      glob_to_multiple: {
        expand: true,
        extDot: 'last',
        src: './public/**/*.coffee',
        ext: '.js'
      }
    },
    scss: {
      dist: {
        files: [{
          expand: true,
          src: ['./public/**/*.scss'],
          ext: '.css'
        }]
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-scss');

  grunt.registerTask('default', ['coffee', 'scss'])
