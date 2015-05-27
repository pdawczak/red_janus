require "test_helper"

class LegacyActiveRecordTest < ActiveSupport::TestCase
  test "properly initializes model rewriting keys" do
    attrs = { plainPassword: "cxztest" }
    model = TestModel.new(attrs)
    assert_equal "cxztest", model.password

    attrs = { "plainPassword" => "testing321" }
    model = TestModel.new(attrs)
    assert_equal "testing321", model.password
  end

  test "lets configure attr key rewrites" do
    attrs = { "plain_password" => "test123" }
    model = TestModel.new(attrs)
    assert_equal "test123", model.password

    attrs = { plain_password: "samplePass" }
    model = TestModel.new(attrs)
    assert_equal "samplePass", model.password
  end

  test "rewrite legacy-like attr names" do
    attrs = { plainPassword: "just_test" }
    model = TestModel.new(attrs)
    assert_equal "just_test", model.password
  end

  test "properly decrements values" do
    model = TestModel.new(refreshed_times: 3)
    model.decrement(:refreshed)
    assert_equal 2, model.refreshed_times
    model.decrement!(:refreshed)
    assert_equal 1, model.refreshed_times
  end

  test "properly increments values" do
    model = TestModel.new(refreshed_times: 3)
    model.increment(:refreshed)
    assert_equal 4, model.refreshed_times
    model.increment!(:refreshed)
    assert_equal 5, model.refreshed_times
  end

  test "properly toggles attr" do
    model = TestModel.new(already_seen: true)
    model.toggle(:seen)
    refute model.already_seen
    model.toggle!(:seen)
    assert model.already_seen
  end

  test "propely touches" do
    model = TestModel.new(published_on: Date.parse("2011-01-03"),
                          last_seen_at: Date.parse("2013-02-02"),
                          updated_at:   Date.parse("2013-03-20"))

    travel_to Time.parse("2015-03-04")

    model.touch(:published, :last_seen)
    assert_equal "2015-03-04", model.published_on.strftime("%Y-%m-%d")
    assert_equal "2015-03-04", model.last_seen_at.strftime("%Y-%m-%d")
    assert_equal "2013-03-20", model.updated_at.strftime("%Y-%m-%d")

    travel_back
  end

  test "properly updates attrs" do
    model = TestModel.new
    model.update({ plainPassword: "zxc123" })
    assert_equal "zxc123", model.password
  end

  test "properly updates single attr" do
    model = TestModel.new
    model.update_attr(:plainPassword, "cxz321")
    assert_equal "cxz321", model.password
  end

  test "properly updates columns" do
    model = TestModel.new
    model.update_columns(plainPassword: "xzc123", seen: true)
    assert_equal "xzc123", model.password
    assert model.already_seen
  end
end

class FakeActiveRecord
  attr_accessor :password, :refreshed_times, :already_seen,
                :published_on, :last_seen_at, :updated_at

  def initialize(attrs = {})
    set_attrs(attrs)
  end

  def decrement(attr, by = 1)
    send("#{attr}=", send("#{attr}") - by)
  end

  def decrement!(attr, by = 1)
    send("#{attr}=", send("#{attr}") - by)
  end

  def increment(attr, by = 1)
    send("#{attr}=", send("#{attr}") + by)
  end

  def increment!(attr, by = 1)
    send("#{attr}=", send("#{attr}") + by)
  end

  def toggle(attr)
    send("#{attr}=", !send("#{attr}"))
  end

  def toggle!(attr)
    send("#{attr}=", !send("#{attr}"))
  end

  def touch(*attrs)
    current = Time.current
    attrs.each do |attr|
      send("#{attr}=", current)
    end
  end

  def update(attrs)
    set_attrs(attrs)
  end

  def update_attr(attr, val)
    send("#{attr}=", val)
  end

  def update_columns(attrs)
    set_attrs(attrs)
  end

  private

  def set_attrs(attrs)
    attrs.each do |k, v|
      send("#{k}=", v)
    end
  end
end

class TestModel < FakeActiveRecord
  include Utils::LegacyActiveRecord

  rewrite plain_password: :password
  rewrite refreshed:      :refreshed_times
  rewrite seen:           :already_seen
  rewrite published: :published_on,
          last_seen: :last_seen_at,
          updated:   :updated_at
end
