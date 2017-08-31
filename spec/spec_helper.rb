RSpec.configure do |config|
  require "factory_girl_rails"

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = "spec/examples.txt"
  config.default_formatter = "doc" if config.files_to_run.one?
  config.order = :random
  config.include FactoryGirl::Syntax::Methods
  FactoryGirl.definition_file_paths = [
    File.expand_path("../factories", __FILE__)
  ]

  Kernel.srand config.seed
  # config.profile_examples = 10
end
