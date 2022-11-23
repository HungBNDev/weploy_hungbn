class TimesheetEntriesController < ApplicationController
  def index
    @timesheet_entries = TimesheetEntry.all.decorate
  end

  def new
    @timesheet_entry = TimesheetEntry.new
  end

  def create
    @timesheet_entry = TimesheetEntry.new(timesheet_entry_params)

    if @timesheet_entry.save
      redirect_to action: :index, notice: 'Timesheet Create Successfully!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def timesheet_entry_params
      params.require(:timesheet_entry).permit(:date_entry, :time_start, :time_end)
    end
end
