class TimesheetEntry < ApplicationRecord
  validates :date_entry, presence: true, comparison: { less_than_or_equal_to: Date.current }
  validates :time_start, presence: true, comparison: { less_than: :time_end }
  # The comparison may be greater_than_or_equal_to. It depends on the requirements of business logic.
  validates :time_end, presence: true

  validate :overlapped_time_entries

  def overlapped_time_entries
    overlapped =  TimesheetEntry.where("time_start <= :current_end AND time_end >= :current_start", {
      current_start: time_start,
      current_end: time_end
    }).last

    if overlapped && overlapped.id != id
      errors.add(:time_start, :overlapped)
    end
  end
end
