require 'test_helper'

class GakunenTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Gakunen::VERSION
  end

  def test_it_does_something_useful
    assert_equal '小3', Gakunen.gakunen(Date.civil(2009, 2, 24), Date.civil(2018, 2, 26))
    assert_equal '小5', Gakunen.gakunen(Date.civil(2006, 9, 15), Date.civil(2018, 2, 26))
  end

  # http://www.mext.go.jp/a_menu/shotou/shugaku/detail/1309966.htm
  #  - 満6才から小学校1年生となる(6歳に達した日の翌日以後における最初の学年の初めから...)
  #  - 学年 → 4/1 に始まり翌年の 3/31 まで
  #  - 一学年は 4/2 生まれ～翌年の 4/1 生まれまでの子で構成される
  def test_cornercase
    assert_equal '小3', Gakunen.gakunen(Date.civil(2009, 2, 24), Date.civil(2018, 2, 23)) # FIXME: Logic書け!
  end
end
