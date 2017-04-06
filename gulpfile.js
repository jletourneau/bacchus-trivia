var gulp = require('gulp');

gulp.task('css', function () {
  var purify = require('gulp-purifycss'),
      csso = require('gulp-csso'),
      build_dir = 'build',
      stylesheets_dir = build_dir + '/assets/stylesheets',
      js_dir = build_dir + '/assets/javascripts';
  return gulp
    .src(stylesheets_dir + '/**/*.css')
    .pipe(purify([
      js_dir + '/**/*.js',
      build_dir + '/**/*.html'
    ]))
    .pipe(csso({
      restructure: true,
      comments: false
    }))
    .pipe(gulp.dest(stylesheets_dir))
});

gulp.task('default', ['css']);
