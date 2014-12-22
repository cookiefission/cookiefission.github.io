module.exports = (grunt) ->
  grunt.initConfig
    evil_icons:
      dist:
        "build/index.html": "src/index.html"

  grunt.loadNpmTasks('grunt-evil-icons')
