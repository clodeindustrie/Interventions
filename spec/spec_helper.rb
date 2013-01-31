require 'rspec'
# set test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

require File.join(File.dirname(__FILE__), '..', 'app.rb')

RSpec.configure do |config|
  config.color_enabled = true
  # Use color not only in STDOUT but also in pagers and files
  config.tty = true
  # Use the specified formatter
  config.formatter = :documentation

  config.before do
    # create DB
  end

  config.after do
    # delete DB
  end
end
