module.exports = (grunt) ->

  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-sass"
  grunt.loadNpmTasks "grunt-contrib-cssmin"

  grunt.config.init

    watch:
      scripts:
        files: [ "./script/**/*.coffee", "!./**/Gruntfile.coffee" ],
        tasks: [ "coffee:compile" ]
      styles:
        files: [ "./**/*.sass" ]
        tasks: [ "sass:compile" ]
      minificationjs:
        files: [ "./script/**/*.js", "!./script/**/*.min.js" ]
        tasks: [ "uglify:minificationall" ]
      minificationcss:
        files: [ "./**/*.css", "!./**/*.min.css" ]
        tasks: [ "cssmin:minification" ]

    uglify:
      minificationall:
        files: [
          expand: on
          cwd: "./"
          src: [ "./script/**/*.js", "!./script/**/*.min.js" ]
          dest: "./"
          ext: ".min.js"
        ]

    coffee:
      compile:
        files: [
          expand: on
          cwd: "./"
          src: [ "./script/**/*.coffee", "!Gruntfile.coffee" ]
          dest: "./"
          ext: ".js"
        ]

    sass:
      compile:
        options:
          sourcemap: "none"
        files: [
          expand: on
          cwd: "./"
          src: [ "./**/*.sass" ]
          dest: "./"
          ext: ".css"
        ]

    cssmin:
      minification:
        files: [
          expand: on
          cwd: "./"
          src: [ "./**/style.css" ]
          dest: "./"
          ext: ".min.css"
        ]