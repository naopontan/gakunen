require 'test_helper'

class GakunenTest < Minitest::Test

  def setup
    @leo  = Date.civil(2004, 3, 23)
    @haru = Date.civil(2006, 9, 15)
    @rika = Date.civil(2009, 2, 24)
  end

  def test_that_it_has_a_version_number
    refute_nil ::Gakunen::VERSION
  end

  def test_sample_case
    assert_equal '小3', Gakunen.gakunen(@rika, Date.civil(2018, 2, 26)), 'リカ'
    assert_equal '小5', Gakunen.gakunen(@haru, Date.civil(2018, 2, 26)), 'ハル'
  end

  # http://www.mext.go.jp/a_menu/shotou/shugaku/detail/1309966.htm
  #  - 満6才から小学校1年生となる(6歳に達した日の翌日以後における最初の学年の初めから...)
  #  - 学年 → 4/1 に始まり翌年の 3/31 まで
  #  - 一学年は 4/2 生まれ～翌年の 4/1 生まれまでの子で構成される
  def test_cornercase
    assert_equal '小3', Gakunen.gakunen(@rika, Date.civil(2018, 2, 23)), 'リカ'
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

  def test_list
    # 1999/4/2 ～ 2000/4/1 が 2006に入学
#    assert_equal '小1', Gakunen.gakunen(Date.civil(1999, 4, 2), Date.civil(2006, 4, 1)), '7才で一年生'
#    assert_equal '小1', Gakunen.gakunen(Date.civil(2000, 4, 1), Date.civil(2006, 4, 1)), '6才で一年生. 早生まれ'
  end

end
__END__
1999/4/2  満6才は 2005/4/2  入学は 2006/4/1
1999/12/31  満6才は 2005/12/31  入学は 2006/4/1

2000/1/1  満6才は 2006/1/1  入学は 2006/4/1
2000/3/31 満6才は 2006/3/31 入学は 2006/4/1
2000/4/1  満6才は 2006/4/1  入学は 2006/4/1

2000/4/2  満6才は 2006/4/2  入学は 2007/4/1
2000/12/31  満6才は 2006/12/31  入学は 2007/4/1


----
1999/4/2 ～ 2000/4/1 が 2006に入学
2005/4/2 ～ 2006/4/1 に満6才が入学

すなわち、4/2 時点で満6才なら小1
