require "gakunen/version"
require "date"

module Gakunen
  TABLE = {
    7 =>  '小1',
    8 =>  '小2',
    9 =>  '小3',
    10 => '小4',
    11 => '小5',
    12 => '小6',
  }

  def self.gakunen(dob, today = Date.today)
    n = age(dob, today)
    TABLE[n]
  end

  def self.age(dob, today)
    x = today.year - dob.year
    (today >= dob >> 12 * x) ? x : x - 1  # 演算子優先度は *, >>, >= の順
  end
end
