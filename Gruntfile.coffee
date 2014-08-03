module.exports = (grunt) ->
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    watch: {
      options: {
        livereload: true
      },
      css: {
        files: './public/**/*.scss',
        tasks: 'sass'
      },
      coffee: {
        files: './public/**/*.coffee',
        tasks: 'coffee'
      },
      jade: {
        files: './public/**/*.jade',
        tasks: 'build'
      }
    },
    coffee: {
      glob_to_multiple: {
        expand: true,
        extDot: 'last',
        src: './public/**/*.coffee',
        ext: '.js'
      }
    },
    sass: {
      dist: {
        files: {
          './public/css/style.css': './public/scss/style.scss'
        }
      }
    }
  })

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-contrib-sass')

  grunt.registerTask('build', ['coffee', 'sass'])
  grunt.registerTask('default', ['build', 'watch'])
