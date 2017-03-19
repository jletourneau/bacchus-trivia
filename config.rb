config[:css_dir]    = 'assets/stylesheets'
config[:js_dir]     = 'assets/javascripts'
config[:images_dir] = 'assets/images'
config[:fonts_dir]  = 'assets/fonts'

config[:layouts_dir]  = '_layouts'
config[:partials_dir] = '_partials'

require 'sprockets/es6'
activate :sprockets do |config|
  config.supported_output_extensions << '.es6'
end

# Add paths for Foundation since we needed to do require: false in the Gemfile
if (foundation_path = Gem::Specification.find_by_name('foundation-rails').gem_dir)
  sprockets.append_path(File.join(foundation_path, 'vendor', 'assets', 'scss'))
  sprockets.append_path(File.join(foundation_path, 'vendor', 'assets', 'js'))
end

configure :development do
  activate :livereload, no_swf: true
end

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
end
