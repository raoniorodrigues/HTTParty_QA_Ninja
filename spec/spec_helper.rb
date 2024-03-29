require_relative "routes/sessions"
require_relative "routes/equipos"
require_relative "routes/signup"
require_relative "routes/base_api"
require "allure-rspec"

require_relative "helpers"
require_relative "libs/mongo"

require "digest/md5"

def to_md5(pass)
  return Digest::MD5.hexdigest(pass)
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before(:suite) do
    users = [
      { name: "Edward", email: "ed@gmail.com", password: to_md5("pwd123") },
      { name: "Joe Ramone", email: "joe@gmail.com", password: to_md5("pwd123") },
      { name: "Raoni", email: "raoni.rodriguess@gmail.com", password: to_md5("pwd123") },
      { name: "Penelope", email: "penelope.rodriguess@gmail.com", password: to_md5("pwd123") },
    ]

    MongoDB.new.drop_danger
    MongoDB.new.insert_user(users)
  end
end

RSpec.configure do |config|
  config.formatter = AllureRspecFormatter
end

AllureRspec.configure do |config|
  config.results_directory = "report"
  config.clean_results_directory = true
  config.logging_level = Logger::INFO
  config.logger = Logger.new($stdout, Logger::DEBUG)
  config.environment = "staging"
end
