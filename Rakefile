require 'middleman-gh-pages'

desc 'Remove build directory completely.'
task :clean do
  rm_rf '.sass-cache'
  rm_rf '.gulp-tmp'
  rm_rf 'build'
end

desc 'Build site with Middleman and run default Gulp task to optimize assets.'
task :build do
  system({}, 'bundle exec middleman build')
end
