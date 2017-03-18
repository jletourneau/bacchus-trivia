config[:css_dir]    = 'assets/stylesheets'
config[:js_dir]     = 'assets/javascripts'
config[:images_dir] = 'assets/images'
config[:fonts_dir]  = 'assets/fonts'

config[:layouts_dir]  = '_layouts'
config[:partials_dir] = '_partials'

# activate :sprockets

configure :development do
  activate :livereload, no_swf: true
end

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
end
