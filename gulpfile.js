var gulp = require('gulp'),
    manifest_filename = 'rev-manifest.json',
    gulp_dir = '.tmp',
    build_dir = 'build',
    assets_dir = build_dir + '/assets',
    stylesheets_dir = assets_dir + '/stylesheets',
    js_dir = assets_dir + '/javascripts',
    images_dir = assets_dir + '/images',
    vendor_js_dir = 'vendor/js';

gulp.task('modernizr', function () {
  var modernizr = require('modernizr'),
      write = require('write'),
      js_file = (vendor_js_dir + '/modernizr.js');
  modernizr.build(
    {
      classPrefix: '',
      options: [
        'setClasses'
      ],
      'feature-detects': [
      ]
    },
    function (js) { write(js_file, js, function (err) {}); }
  );
});

gulp.task('css', function () {
  var purify = require('gulp-purifycss'),
      csso = require('gulp-csso');
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
    .pipe(gulp.dest(stylesheets_dir));
});

gulp.task('rev', ['css'], function () {
  var rev = require('gulp-rev'),
      delete_original = require('gulp-rev-delete-original');
  return gulp
    .src(build_dir + '/**/*.css')
    .pipe(rev())
    .pipe(delete_original())
    .pipe(gulp.dest(build_dir))
    .pipe(rev.manifest({ path: manifest_filename }))
    .pipe(gulp.dest(gulp_dir));
});

gulp.task('rev_replace', ['rev'], function () {
  var rev_replace = require('gulp-rev-replace'),
      manifest = gulp.src([gulp_dir, manifest_filename].join('/'));
  return gulp
    .src(build_dir + '/**/*.html')
    .pipe(rev_replace({ manifest: manifest }))
    .pipe(gulp.dest(build_dir));
});

gulp.task('before_build', ['modernizr'])
gulp.task('default', ['rev_replace']);
