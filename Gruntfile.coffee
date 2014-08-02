module.exports = (grunt) ->
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    watch: {
      files: ['./public/**/*.coffee'],
      tasks: ['coffee'],
    },
    coffee: {
      glob_to_multiple: {
        expand: true,
        extDot: 'last',
        src: './public/**/*.coffee',
        ext: '.js'
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-watch');

  grunt.registerTask('default', ['coffee'])
