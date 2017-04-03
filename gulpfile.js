var gulp = require('gulp');

gulp.task('uncss', function () {
  var uncss = require('gulp-uncss'),
      csso = require('gulp-csso'),
      build_dir = 'build',
      stylesheets_dir = build_dir + '/assets/stylesheets';
  return gulp
    .src(stylesheets_dir + '/**/*.css')
    .pipe(uncss({
      html: [build_dir + '/**/*.html']
    }))
    .pipe(csso({
      comments: false
    }))
    .pipe(gulp.dest(stylesheets_dir))
});

// gulp.task('default', ['uncss']);
