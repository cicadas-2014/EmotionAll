require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module EmotionAll
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.after_initialize do
        class Cache

          attr_reader :map_info, :updated_at

          def initialize
            @map_info = {}
            ActiveRecord::Base.connection.tables
            if ActiveRecord::Base.connection.table_exists?('Trends')
                Trend.all.each do |t|
                  @map_info[t.id] = Trend.map_info(t.id)
                end
            @updated_at = Time.now
            end
          end
        end

        Rails.cache.write('cache', Cache.new)
    end
  end
end


