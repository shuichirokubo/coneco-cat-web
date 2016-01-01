# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

## Stylesheets
Rails.application.config.assets.precompile += %w( bootstrap.min.css )
Rails.application.config.assets.precompile += %w( nivo-lightbox.css )
Rails.application.config.assets.precompile += %w( nivo-lightbox-theme/default/default.css )
Rails.application.config.assets.precompile += %w( owl.carousel.css )
Rails.application.config.assets.precompile += %w( owl.theme.css )
Rails.application.config.assets.precompile += %w( animate.css )
Rails.application.config.assets.precompile += %w( style.css )

## JavaScripts
Rails.application.config.assets.precompile += %w( jquery.min.js )
Rails.application.config.assets.precompile += %w( bootstrap.min.js )
Rails.application.config.assets.precompile += %w( jquery.easing.min.js )
Rails.application.config.assets.precompile += %w( jquery.sticky.js )
Rails.application.config.assets.precompile += %w( jquery.scrollTo.js )
Rails.application.config.assets.precompile += %w( stellar.js )
Rails.application.config.assets.precompile += %w( wow.min.js )
Rails.application.config.assets.precompile += %w( owl.carousel.min.js )
Rails.application.config.assets.precompile += %w( nivo-lightbox.min.js )
Rails.application.config.assets.precompile += %w( custom.js )
Rails.application.config.assets.precompile += %w( rakuten-cats.pics-carousel.js )
Rails.application.config.assets.precompile += %w( instagram-cats.pics-carousel.js )
Rails.application.config.assets.precompile += %w( flickr-cats.pics-carousel.js )

## Images
Rails.application.config.assets.precompile += %w( cats.pics-logo.png )
Rails.application.config.assets.precompile += %w( cat2.pics-logo.png )
