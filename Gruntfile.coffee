module.exports = (grunt) ->
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    watch: {
      options: {
        livereload: true
      },
      css: {
        files: './public/**/*.scss',
        tasks: 'scss'
      },
      coffee: {
        files: './public/**/*.coffee',
        tasks: 'coffee'
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
    scss: {
      dist: {
        files: {
          'style.css': 'style.scss'
        }
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-scss');

  grunt.registerTask('default', ['coffee', 'scss'])
