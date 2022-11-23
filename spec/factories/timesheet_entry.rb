FactoryBot.define do
  factory :timesheet_entry do
    date_entry { Faker::Date.between(from: 2.years.ago.to_s, to: Date.current.to_s) }
    time_start { Faker::Time.between(from: date_entry.to_time.beginning_of_day.to_s, to: date_entry.to_time.end_of_day.to_s) }
    time_end { Faker::Time.between(from: time_start.to_s, to: date_entry.to_time.end_of_day.to_s) }
  end
end
