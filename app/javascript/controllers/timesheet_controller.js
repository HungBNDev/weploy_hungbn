import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    $(document).on('change', '.select-time', (e) => {
      const entryDate = $('#timesheet_entry_date_entry').val();
      const timeStart = `${entryDate}T${$('#timesheet_entry_time_start').val()}:00+00:00`;
      const timeEnd = `${entryDate}T${$('#timesheet_entry_time_end').val()}:00+00:00`;

      $('.actual-time-start').val(timeStart);
      $('.actual-time-end').val(timeEnd);
    });
  }
}
