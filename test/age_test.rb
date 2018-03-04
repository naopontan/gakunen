require 'test_helper'

class AgeTest < Minitest::Test

  def setup
    @leo  = Date.civil(2004, 3, 24)
    @haru = Date.civil(2006, 9, 16)
    @rika = Date.civil(2009, 2, 25)
  end

  def test_age
    assert_equal 6, Date.civil(1999, 4, 2).age(Date.civil(2006, 4, 1))
    assert_equal 6, Date.civil(1999, 4, 2).age(Date.civil(2006, 4, 1))
    assert_equal 6, Date.civil(2000, 4, 1).age(Date.civil(2006, 4, 1))
  end

  def test_rika_age
    assert_equal 6, @rika.age(Date.civil(2015, 2, 28))
    assert_equal 7, @rika.age(Date.civil(2016, 2, 28)), '1年生'
    assert_equal 8, @rika.age(Date.civil(2017, 2, 28)), '2年生'
    assert_equal 9, @rika.age(Date.civil(2018, 2, 28)), '3年生'
  end

  def test_leo_age
    assert_equal 13, @leo.age(Date.civil(2018, 2, 28)), '中2'
  end

end
