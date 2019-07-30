require "test_helper"
require_relative "../lib/helpers/databaseAdapter"

class DataCollectorTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil ::DataCollector::VERSION
  end

  def test_database_token
    assert DataCollector::DatabaseAdapter.new.get_token
  end

end
