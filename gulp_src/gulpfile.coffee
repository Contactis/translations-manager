gulp = require('gulp')
sass = require('gulp-sass')
uglify = require('gulp-uglify')
coffee = require('gulp-coffee')
less = require('gulp-less')
csso = require('gulp-csso')
clean = require('gulp-clean')

gulp.task('coffee', () ->
    gulp.src('public/coffee/**/*.coffee')
        .pipe(coffee())
        .pipe(gulp.dest('public/javascripts'))
)

gulp.task('js', () ->
  # Minify and copy all JavaScript (except vendor scripts)
    gulp.src(['public/javascripts/**/*.js', '!public/javascripts/vendor/**'])
        .pipe(uglify())
        .pipe(gulp.dest('build/javascripts'))

    # Copy vendor files
    gulp.src('public/javascripts/vendor/**')
        .pipe(gulp.dest('build/javascripts/vendor'))
)

gulp.task('less', () ->
    gulp.src('public/less/**/*.less')
        .pipe(less())
        .pipe(gulp.dest('public/stylesheets'))
)

gulp.task('css', () ->
    # Minify and copy all JavaScript (except vendor scripts)
    gulp.src(['public/stylesheets/**/*.css', '!public/javascripts/vendor/**'])
        .pipe(csso())
        .pipe(gulp.dest('build/stylesheets'))

    # Copy vendor files
    gulp.src('public/stylesheets/vendor/**')
        .pipe(gulp.dest('build/stylesheets/vendor'))
)

# Copy all static assets
gulp.task('copy', () ->
    gulp.src('public/images/**')
        .pipe(gulp.dest('build/images'))
    gulp.src('public/**/*.html')
        .pipe(gulp.dest('build'))
)

gulp.task('watch', () ->
    gulp.watch('public/coffee/**', (event) ->
        gulp.run('coffee')
    )
    gulp.watch('public/less/**', (event) ->
        gulp.run('less')
    )
)

# The default task (called when you run `gulp`)
gulp.task('default', () ->
    gulp.run('coffee', 'js', 'less', 'css', 'copy')
)

gulp.task('clean', () ->
    gulp.src('build')
      .pipe(clean())
)


