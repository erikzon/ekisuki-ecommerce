ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def login
    post sessions_path, params: {login: 'erick', password: '123456'}
  end

  def loginAdmin
    post sessions_path, params: {login: 'laura', password: '123456'}
  end
  # Add more helper methods to be used by all tests here...
end
