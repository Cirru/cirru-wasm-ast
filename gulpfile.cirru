
var
  gulp $ require :gulp

gulp.task :script $ \ ()
  var
    script $ require :gulp-cirru-script
  ... gulp
    src :src/**/*.cirru
    pipe (script)
    pipe $ gulp.dest :lib/
