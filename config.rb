config[:css_dir] = 'assets/stylesheets'
config[:js_dir] = 'assets/javascripts'
config[:images_dir] = 'assets/images'
config[:fonts_dir] = 'assets/fonts'
config[:layouts_dir] = '_layouts'

# Need to configure ES6 support to compile JavaScript from Foundation
require 'sprockets/es6'
activate :sprockets do |config|
  config.supported_output_extensions << '.es6'
end

# Allow Sprockets to bring in resources from NPM-installed modules
sprockets.append_path(File.join(root, 'node_modules'))

# Path for Gulp-generated resources we want to allow Sprockets to use
sprockets.append_path(File.join(root, '.gulp-tmp'))

# Add paths for Foundation since we needed to do require: false in the Gemfile
if (foundation_path = Gem::Specification.find_by_name('foundation-rails').gem_dir)
  sprockets.append_path(File.join(foundation_path, 'vendor', 'assets', 'scss'))
  sprockets.append_path(File.join(foundation_path, 'vendor', 'assets', 'js'))
end

# Modes

configure :server do
end

configure :build do
  set :haml, ugly: true

  activate :minify_html do |html|
    html.remove_input_attributes = false
    html.remove_intertag_spaces = false
  end

  require 'uglifier'
  activate :minify_javascript, compressor: proc {
    ::Uglifier.new(
      output: {
        comments: :none,
      },
    )
  }

  # Skip hashing for CSS files since we're going to do that with gulp after
  # doing some more processing on them.
  activate :asset_hash, ignore: %r{.*\.css$}

  after_configuration do
    system './node_modules/gulp/bin/gulp.js before_build'
  end

  after_build do
    system './node_modules/gulp/bin/gulp.js default'
  end
end

# Environments

configure :development do
  activate :livereload, no_swf: true, host: 'localhost'
end

configure :production do
end
