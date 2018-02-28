require 'test_helper'

class GakunenTest < Minitest::Test

  def setup
    @leo  = Date.civil(2004, 3, 24)
    @haru = Date.civil(2006, 9, 16)
    @rika = Date.civil(2009, 2, 25)
  end

  def test_that_it_has_a_version_number
    refute_nil ::Gakunen::VERSION
  end

  def test_sample_case
    today = Date.civil(2018, 2, 26)
    assert_equal '小3', Gakunen.gakunen(@rika, today)
    assert_equal '小5', Gakunen.gakunen(@haru, today)
    assert_equal '中2', Gakunen.gakunen(@leo, today)
  end

  # http://www.mext.go.jp/a_menu/shotou/shugaku/detail/1309966.htm
  #  - 満6才から小学校1年生となる(6歳に達した日の翌日以後における最初の学年の初めから...)
  #  - 学年 → 4/1 に始まり翌年の 3/31 まで
  #  - 一学年は 4/2 生まれ～翌年の 4/1 生まれまでの子で構成される
  def test_cornercase
    assert_equal '小3', Gakunen.gakunen(@rika, Date.civil(2018, 2, 28))
  end

  def test_age
    assert_equal 6, Gakunen.age(Date.civil(1999, 4, 2), Date.civil(2006, 4, 1))
    assert_equal 6, Gakunen.age(Date.civil(2000, 4, 1), Date.civil(2006, 4, 1))
  end

  def test_rika_age
    assert_equal 6, Gakunen.age(@rika, Date.civil(2015, 2, 28))
    assert_equal 7, Gakunen.age(@rika, Date.civil(2016, 2, 28)), '1年生'
    assert_equal 8, Gakunen.age(@rika, Date.civil(2017, 2, 28)), '2年生'
    assert_equal 9, Gakunen.age(@rika, Date.civil(2018, 2, 28)), '3年生'
  end

  def test_leo_age
    assert_equal 13, Gakunen.age(@leo, Date.civil(2018, 2, 28)), '中2'
  end

  def test_list
    # 1999/4/2 ～ 2000/4/1 が 2006に入学
    assert_equal '小1', Gakunen.gakunen(Date.civil(1999, 4, 2), Date.civil(2006, 4, 1)), '7才で一年生'
    assert_equal '小1', Gakunen.gakunen(Date.civil(2000, 4, 1), Date.civil(2006, 4, 1)), '6才で一年生. 早生まれ'
  end

end
