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

# Paths for files we may want to manually include in assets
sprockets.append_path(File.join(root, 'vendor', 'js'))

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

  # Gulp handles this after the build
  # activate :minify_css

  activate :asset_hash
end

# Environments

configure :development do
  activate :livereload, no_swf: true
end

configure :production do
end
