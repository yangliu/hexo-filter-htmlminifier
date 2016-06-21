gulp = require 'gulp'
$ = require('gulp-load-plugins')()

lib = 'lib/**/*.coffee'

gulp.task 'coffeelint', ->
  gulp.src lib
    .pipe $.coffeelint()
    .pipe $.coffeelint.reporter()