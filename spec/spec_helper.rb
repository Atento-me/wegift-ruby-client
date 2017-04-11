require 'bundler/setup'
require 'dotenv/load'
require 'wegift/client'
require 'webmock/rspec'
require 'vcr'

def set_wegift_client
  Wegift::Client.new(
      :api_key      => ENV['AUTH_NAME'],
      :api_secret   => ENV['AUTH_PASS'],
      :test_mode    => true
  )
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/tapes'
  c.hook_into :webmock
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
