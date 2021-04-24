RSpec.describe "POST api/auth/sign_in", type: :request do
  let(:user) { create(:user) }
  let(:expected_response) do
    {
      "data" => {
        "id" => user.id, "uid" => user.email, "email" => user.email, 
        "provider" => "email", "allow_password_change" => false,
      },
    }
  end

  describe "successfully with valid credentials" do
    before do
      post '/api/auth/sign_in', params: {
        email: user.email,
        password: user.password
      }
    end

    it 'is expected to return 200 status' do
      expect(response).to have_http_status 200
    end
  
    it 'is expected to return information about user' do
      expect(response_json).to eq expected_responce
    end

  end
end
