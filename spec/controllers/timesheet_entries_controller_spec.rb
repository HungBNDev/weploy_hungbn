require 'rails_helper'

RSpec.describe TimesheetEntriesController do
  describe "GET index" do
    let!(:ts_entry_today) { create :timesheet_entry, date_entry: Date.current }
    let!(:ts_entry_yesterday) { create :timesheet_entry, date_entry: Date.yesterday }

    it 'Should response the index template and return status 200' do
      get :index
      expect(response).to render_template(:index)
      expect(response.status).to eq(200)
      expect(assigns(:timesheet_entries)).to match_array([ts_entry_today, ts_entry_yesterday])
    end
  end

  describe 'POST create' do
    let(:timesheet_entry_params) { { date_entry: Date.current, time_start: Time.current.change(hour: 8), time_end: Time.current.change(hour: 15) } }
    let(:params) { { timesheet_entry: timesheet_entry_params } }

    context 'With valid parameters' do
      it 'Should create a new timesheet entry and return success to user' do
        expect { post :create, params: params }.to change { TimesheetEntry.count }.by(1)
        expect(response.status).to eq(302)
        expect(response).to redirect_to(action: :index, notice: 'Timesheet Create Successfully!')
      end
    end

    context 'With invalid parameters' do
      let!(:existing_entry) { create :timesheet_entry, date_entry: Date.current, time_start: Time.current.change(hour: 8), time_end: Time.current.change(hour: 15) }

      it 'Should render new with overlapped validate error message' do
        expect { post :create, params: params }.to change { TimesheetEntry.count }.by(0)
        expect(response.status).to eq(422)
        expect(response).to render_template(:new)
        expect(assigns(:timesheet_entry).errors.full_messages).to eq(["Time start This Time entry was chosen, Please select another Start Time / Finish Time."])
      end
    end
  end

  describe "GET new" do
    it 'Should response the index template and return status 200' do
      get :new
      expect(response).to render_template(:new)
      expect(response.status).to eq(200)
      expect(assigns(:timesheet_entry)).to be_a_new(TimesheetEntry)
    end
  end
end
