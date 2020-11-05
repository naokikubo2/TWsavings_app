module SavingsRecordsHelper
  def savings_total
    @savings_records.all.sum(:earned_time) * current_user.hourly_pay / 60
  end
  def savings_today
    @savings_records.where(savings_date: Date.today).all.sum(:earned_time) * current_user.hourly_pay / 60
  end
  def calc_pay(savings_record)
    savings_record.earned_time * current_user.hourly_pay / 60
  end
  def calc_hour(savings_record)
    (savings_record.earned_time).div(60)
  end
  def calc_minuite(savings_record)
    savings_record.earned_time.modulo(60)
  end
  def format_date(date)
    dw = ["日", "月", "火", "水", "木", "金", "土"]
    date.strftime("%Y/%m/%d(#{dw[date.wday]}) %H:%M")
  end
end
