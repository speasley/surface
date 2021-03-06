require "rails_helper"

describe TrainingSessionsController do
  let(:user) { create(:user) }

  before :each do
    http_login(user)
  end

  describe "#index" do
    include_context "stronglifts_program"
    let!(:training_session_a) { create(:training_session, user: user, workout: workout_a) }
    let!(:training_session_b) { create(:training_session, user: user, workout: workout_b) }

    it "loads all my training sessions" do
      get :index
      expect(assigns(:training_sessions)).to match_array([training_session_a, training_session_b])
    end
  end

  describe "#upload" do
    include_context "stronglifts_program"
    let(:backup_file) { fixture_file_upload("backup.android.stronglifts") }

    before :each do
      allow(UploadStrongliftsBackupJob).to receive(:perform_later)
    end

    it "uploads a new backup" do
      post :upload, backup: backup_file
      expect(UploadStrongliftsBackupJob).to have_received(:perform_later)
    end

    it "redirects to the dashboard" do
      post :upload, backup: backup_file
      expect(response).to redirect_to(dashboard_path)
    end

    it "displays a friendly message" do
      post :upload, backup: backup_file
      translation = I18n.translate("training_sessions.upload.success")
      expect(flash[:notice]).to eql(translation)
    end
  end
end
