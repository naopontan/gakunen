class Date
  # 満年齢
  def age(today)
    x = today.year - self.year
    (today >= self >> 12 * x) ? x : x - 1  # 演算子優先度は *, >>, >= の順
  end
end
