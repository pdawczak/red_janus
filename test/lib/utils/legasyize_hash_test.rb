require "test_helper"

class Utils::LegacyizeHashTest < ActiveSupport::TestCase
  using Utils::LegacyizeHash

  def test_legacyize
    date_key = Date.new
    hash_key = {}

    hash = { "SampleKey" =>    "var 1",
             anotherKey:       "var 2",
             "another_test" => "var 3",
             last_one:         "var 4",
             date_key =>       "var 5",
             123 =>            "var 6",
             hash_key =>       "var 7" }

    copy = hash.legacyize

    assert_includes copy.keys, "sample_key"
    assert_includes copy.keys, :another_key
    assert_includes copy.keys, "another_test"
    assert_includes copy.keys, :last_one
    assert_includes copy.keys, date_key
    assert_includes copy.keys, 123
    assert_includes copy.keys, hash_key

    assert_equal "var 1", copy["sample_key"]
    assert_equal "var 2", copy[:another_key]
    assert_equal "var 3", copy["another_test"]
    assert_equal "var 4", copy[:last_one]
    assert_equal "var 5", copy[date_key]
    assert_equal "var 6", copy[123]
    assert_equal "var 7", copy[hash_key]
  end
end
