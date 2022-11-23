require 'rails_helper'

RSpec.describe TimesheetEntryDecorator do
  let!(:ts_entry_wednesday) { create :timesheet_entry, date_entry: Date.new(2022, 11, 23), time_start: DateTime.new(2022, 11, 23, 10, 0, 0, '+0'), time_end: DateTime.new(2022, 11, 23, 19, 0, 0, '+0') }
  let!(:ts_entry_tuesday) { create :timesheet_entry, date_entry: Date.new(2022, 11, 22), time_start: DateTime.new(2022, 11, 22, 4, 0, 0, '+0'), time_end: DateTime.new(2022, 11, 22, 22, 0, 0, '+0') }
  let!(:ts_entry_weekend) { create :timesheet_entry, date_entry: Date.new(2022, 11, 20), time_start: DateTime.new(2022, 11, 20, 7, 0, 0, '+0'), time_end: DateTime.new(2022, 11, 20, 19, 0, 0, '+0') }

  describe "#detail" do
    context 'When working in Wed' do
      it { expect(ts_entry_wednesday.decorate.detail).to eq '2022-11-23: 10:00 - 19:00 $198.0' }
    end

    context 'When working in Tue' do
      it { expect(ts_entry_tuesday.decorate.detail).to eq '2022-11-22: 04:00 - 22:00 $510.0' }
    end

    context 'When working at the weekend' do
      it { expect(ts_entry_weekend.decorate.detail).to eq '2022-11-20: 07:00 - 19:00 $564.0' }
    end

    context 'More context ...' do
      'Please see the Allens-Interval-Algebra Algorithm here https://github.com/AndrewClarke/Allens-Interval-Algebra'
      'Figure here https://i.stack.imgur.com/0c6q0.png'
    end
  end
end
