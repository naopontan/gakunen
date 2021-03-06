require "gakunen/version"
require "date"

=begin
# https://ja.wikipedia.org/wiki/%E5%AD%A6%E9%BD%A2
学年早見表
満年齢  学年  学校
0歳   保育所
0歳～1歳    保育所
1歳～2歳    保育所
2歳～3歳    保育所
3歳～4歳  年少  幼稚園、保育所
4歳～5歳  年中  幼稚園、保育所
5歳～6歳  年長  幼稚園、保育所
6歳～7歳  1年 小学校
7歳～8歳  2年 小学校
8歳～9歳  3年 小学校
9歳～10歳 4年 小学校
10歳～11歳  5年 小学校
11歳～12歳  6年 小学校
12歳～13歳  1年 中学校
13歳～14歳  2年 中学校
14歳～15歳  3年 中学校
15歳～16歳  1年 高等学校、高等専門学校
16歳～17歳  2年 高等学校、高等専門学校
17歳～18歳  3年 高等学校、高等専門学校
18歳～19歳  1年。4年  大学、短期大学。高等専門学校
19歳～20歳  2年。5年  大学、短期大学。高等専門学校
20歳～21歳  3年 大学、短期大学
21歳～22歳  4年 大学
22歳～23歳  1年。5年  修士課程。医科大学、獣医学部、薬学科
23歳～24歳  2年。6年  修士課程。医科大学、獣医学部、薬学科
=end

module Gakunen
  TABLE = {
    0 =>  '保育所',
    1 =>  '保育所',
    2 =>  '保育所',
    3 =>  '年少',
    4 =>  '年中',
    5 =>  '年長',

    # 学齢 https://ja.wikipedia.org/wiki/%E5%AD%A6%E9%BD%A2
    # 小1から中3までは義務教育
    6 =>  '小1',
    7 =>  '小2',
    8 =>  '小3',
    9 =>  '小4',
    10 => '小5',
    11 => '小6',

    12 => '中1',
    13 => '中2',
    14 => '中3',

    15 => '高1',
    16 => '高2',
    17 => '高3',

    18 => '大学1',
    19 => '大学2',
    20 => '大学3',
    21 => '大学4',

    22 => '修士課程1',
    23 => '修士課程2',
  }

  # 学年
  # 小1以上は厳密に求める。小1未満も面倒臭いので小1以上のロジックと合わせる
  def gakunen(today = Date.today)
    n = self.age(Date.civil(today.year, 4)) # 基点に寄せる. 学年は 4/1 から始まるから
    n -= 1 if (1..3).include?(today.month)
    TABLE[n]
  end

  # 早生まれ?
  def self.hayaumare?(dob)
    (1..3).include?(dob.month) || (dob.month == 4 && dob.day == 1)
  end

  # 年度
  def self.nendo(date)
    (1..3).include?(date.month) ? date.year - 1 : date.year
  end

  # 満年齢
  # うるう年の場合: 3/1 で加齢とする(「みなし誕生日」の 2/28 ではない)
  def age(today = Date.today)
    return if self > today
    #x = today.year - self.year
    #(today >= self >> 12 * x) ? x : x - 1  # 演算子優先度は *, >>, >= の順

    today.year - year - ((today.month > month || (today.month == month && today.day >= day)) ? 0 : 1)
  end
end

class Date
  include Gakunen
end
