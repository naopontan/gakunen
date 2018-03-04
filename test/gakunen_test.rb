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

  def test_list
    # 1999/4/2 ～ 2000/4/1 が 2006に入学
    assert_equal '小1', Gakunen.gakunen(Date.civil(1999, 4, 2), Date.civil(2006, 4, 1)), '7才で一年生'
    assert_equal '小1', Gakunen.gakunen(Date.civil(2000, 4, 1), Date.civil(2006, 4, 1)), '6才で一年生. 早生まれ'
  end

  def test_under5
    assert_equal '年長', Gakunen.gakunen(Date.civil(2000, 4, 1), Date.civil(2005, 4, 1))
    assert_equal '年中', Gakunen.gakunen(Date.civil(2000, 4, 1), Date.civil(2004, 4, 1))
    assert_equal '年少', Gakunen.gakunen(Date.civil(2000, 4, 1), Date.civil(2003, 4, 1))

    assert_equal '保育所', Gakunen.gakunen(Date.civil(2000, 4, 1), Date.civil(2002, 4, 1))
    assert_equal '保育所', Gakunen.gakunen(Date.civil(2000, 4, 1), Date.civil(2001, 4, 1))
    assert_equal '保育所', Gakunen.gakunen(Date.civil(2000, 4, 1), Date.civil(2000, 4, 1)), '産まれた日に保育所とかあり得ないけど、とりあえず'
  end

  def test_not_born
    assert_nil Gakunen.gakunen(Date.civil(2000, 4, 1), Date.civil(2000, 3, 31)), '生まれていない'
  end

  def test_adult
    assert_nil Gakunen.gakunen(Date.civil(1968, 11, 10), Date.civil(2000, 3, 31)), '学生じゃない'
  end

end
