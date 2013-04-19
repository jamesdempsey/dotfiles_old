Pry.config.should_load_plugins = false
#Pry.plugins["doc"].activate!

# load pry in rails console
rails = File.join Dir.getwd, 'config', 'environment.rb'

if File.exist?(rails) && ENV['SKIP_RAILS'].nil?
  require rails

  rails_v = Rails.version[0..0]
  if rails_v == "2"
    require 'console_app'
    require 'console_with_helpers'
  elsif rails_v == "3" || rails_v == "4"
    require 'rails/console/app'
    require 'rails/console/helpers'
  else
    warn "[WARN] cannot load Rails console commands (Not on Rails2 or Rails3?...or 4?)"
  end

  if defined?(Rails) && Rails.env
    extend Rails::ConsoleMethods
  end
end

# Prompt with ruby version
Pry.prompt = [proc { |obj, nest_level| "#{RUBY_VERSION} (#{obj}):#{nest_level} > " }, proc { |obj, nest_level| "#{RUBY_VERSION} (#{obj}):#{nest_level} * " }]
