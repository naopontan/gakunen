require 'test_helper'

class GakunenTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Gakunen::VERSION
  end

  def test_it_does_something_useful
    assert_equal '小3', Gakunen.gakunen(Date.civil(2009, 2, 24), Date.civil(2018, 2, 26))
    assert_equal '小5', Gakunen.gakunen(Date.civil(2006, 9, 15), Date.civil(2018, 2, 26))
  end

  def test_cornercase
    assert_equal '小3', Gakunen.gakunen(Date.civil(2009, 2, 24), Date.civil(2018, 2, 23)) # FIXME: Logic書け!
  end
end
