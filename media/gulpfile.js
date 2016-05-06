var gulp = require('gulp')
var sass = require('gulp-ruby-sass')
var autoprefixer = require('gulp-autoprefixer')

gulp.task('build', function () {
  return sass('scss/*.scss', {
    style: 'compressed',
    noCache: true
  }).on('error', function (err) {
    console.error(err)
  }).pipe(autoprefixer())
  .pipe(gulp.dest('css'))
})

gulp.task('watch', function () {
  gulp.watch('scss/*.scss', ['build'])
})
