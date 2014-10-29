gulp = require 'gulp'
browserify = require 'gulp-browserify'
uglify = require 'gulp-uglify'
saveLicense = require 'uglify-save-license'
rename = require 'gulp-rename'
jasmine = require 'gulp-jasmine'
coffee = require 'gulp-coffee'
del = require 'del'

gulp.task 'script:compile', ['clean'], ->
    return gulp.src 'src/lib.coffee', 
            read: false
        .pipe browserify
            transform: ['coffeeify']
            extensions: ['.coffee']
        .pipe rename 'lib-tminus.js'
        .pipe gulp.dest 'dist'
        .pipe rename
            suffix: '.min'
        .pipe uglify
            preserveComments: saveLicense
        .pipe gulp.dest 'dist'

gulp.task 'script:build-js', ['clean'], ->
    return gulp.src 'src/**/*.coffee'
        .pipe coffee()
        .pipe gulp.dest 'gen-js'

gulp.task 'test', ->
    return gulp.src 'spec/test.coffee'
        .pipe jasmine
            includeStackTrace: true
            verbose: true

gulp.task 'clean', (cb) ->
    del ['dist', 'gen-js'], cb
            
gulp.task 'default', ['script:compile']