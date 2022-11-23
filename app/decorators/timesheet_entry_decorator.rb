class TimesheetEntryDecorator < Draper::Decorator
  delegate_all

  def detail
    "#{date_entry}: #{time_start.strftime("%H:%M")} - #{time_end.strftime("%H:%M")} $#{calculated_amount.round(2)}"
  end

  private

    def calculated_amount
      working_time_spec  = working_time_spec(date_entry)
      time_start_working = working_time_spec.dig(:start)
      time_end_working   = working_time_spec.dig(:end)
      working_times      = working_times(time_start_working, time_end_working)

      working_times.dig(:office_hours).to_f/3600 * working_time_spec.dig(:office_rate) +
      working_times.dig(:overtime_hours).to_f/3600 * working_time_spec.dig(:overtime_rate)
    end

    def working_times(time_start_working, time_end_working)
      intersection_start = [time_start, time_start_working].max
      intersection_end   = [time_end, time_end_working].min
      intersection_hours = intersection_end - intersection_start
      working_hours      = time_end - time_start

      if both_out_of_working_range?(time_start_working, time_end_working)
        { office_hours: 0, overtime_hours: time_end - time_start }
      elsif working_hours == intersection_hours
        { office_hours: working_hours, overtime_hours: 0 }
      else
        { office_hours: intersection_hours, overtime_hours: working_hours - intersection_hours }
      end
    end

    def both_out_of_working_range?(time_start_working, time_end_working)
      time_start >= time_end_working || time_end <= time_start_working
    end

    def working_time_spec(date_entry)
      case date_entry.wday
      when 1, 3, 5
        {
          start: date_entry.to_time.change(hour: 7),
          end: date_entry.to_time.change(hour: 19),
          office_rate: 22,
          overtime_rate: 33
        }
      when 2, 4
        {
          start: date_entry.to_time.change(hour: 5),
          end: date_entry.to_time.change(hour: 17),
          office_rate: 25,
          overtime_rate: 35
        }
      else
        {
          start: date_entry.to_time.change(hour: 0, minute: 0),
          end:  date_entry.to_time.change(hour: 23, minute: 59),
          office_rate: 47,
          overtime_rate: 47
        }
      end
    end
end
