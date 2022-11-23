class CreateTimesheetEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :timesheet_entries do |t|
      t.date :date_entry, null: false
      t.datetime :time_start, null: false
      t.datetime :time_end, null: false

      t.timestamps
    end
  end
end
