# encoding: utf-8

require 'test/helper'

class Nanoc3::ItemTest < MiniTest::Unit::TestCase

  include Nanoc3::TestHelpers

  def test_initialize_with_attributes_with_string_keys
    item = Nanoc3::Item.new("foo", { 'abc' => 'xyz' }, '/foo/')

    assert_equal nil,   item.attributes['abc']
    assert_equal 'xyz', item.attributes[:abc]
  end

  def test_initialize_with_unclean_identifier
    item = Nanoc3::Item.new("foo", {}, '/foo')

    assert_equal '/foo/', item.identifier
  end

  def test_lookup
    # Create item
    item = Nanoc3::Item.new(
      "content",
      { :one => 'one in item' },
      '/path/'
    )

    # Test finding one
    assert_equal('one in item', item[:one])

    # Test finding two
    assert_equal(nil, item[:two])
  end

  def test_set_attribute
    item = Nanoc3::Item.new("foo", {}, '/foo')
    assert_equal nil, item[:motto]

    item[:motto] = 'More human than human'
    assert_equal 'More human than human', item[:motto]
  end

  def test_compiled_content_with_default_rep_and_default_snapshot
    # Mock reps
    rep = mock
    rep.expects(:name).returns(:default)
    rep.expects(:content_at_snapshot).with(:last).returns('compiled stuff')

    # Mock item
    item = Nanoc3::Item.new("foo", {}, '/foo')
    item.expects(:reps).returns([ rep ])

    # Check
    assert_equal 'compiled stuff', item.compiled_content
  end

  def test_compiled_content_with_custom_rep_and_default_snapshot
    # Mock reps
    rep = mock
    rep.expects(:name).returns(:foo)
    rep.expects(:content_at_snapshot).with(:last).returns('compiled stuff')

    # Mock item
    item = Nanoc3::Item.new("foo", {}, '/foo')
    item.expects(:reps).returns([ rep ])

    # Check
    assert_equal 'compiled stuff', item.compiled_content(:rep => :foo)
  end

  def test_compiled_content_with_default_rep_and_custom_snapshot
    # Mock reps
    rep = mock
    rep.expects(:name).returns(:default)
    rep.expects(:content_at_snapshot).with(:blah).returns('compiled stuff')

    # Mock item
    item = Nanoc3::Item.new("foo", {}, '/foo')
    item.expects(:reps).returns([ rep ])

    # Check
    assert_equal 'compiled stuff', item.compiled_content(:snapshot => :blah)
  end

  def test_compiled_content_with_custom_nonexistant_rep
    # Mock item
    item = Nanoc3::Item.new("foo", {}, '/foo')
    item.expects(:reps).returns([])

    # Check
    assert_raises(Nanoc3::Errors::Generic) do
      item.compiled_content(:rep => :lkasdhflahgwfe)
    end
  end

end
