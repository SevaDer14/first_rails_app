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
      expect(response_json).to eq expected_response
    end
  end

  describe "with invalid password" do
    before do
      post '/api/auth/sign_in', params: {
        email: user.email,
        password: "wrong_password"
      }
    end

    it 'is expected to return 401 status' do
      expect(response).to have_http_status 401

    end
  
    it 'returns error message' do
      expect(response_json['errors']).to eq ['Invalid login credentials. Please try again.']
    end
  end
  describe "with invalid email" do
    before do
      post '/api/auth/sign_in', params: {
        email: "wrong@email.com",
        password: user.password
      }
    end

    it 'is expected to return 401 status' do
      expect(response).to have_http_status 401

    end
  
    it 'returns error message' do
      expect(response_json['errors']).to eq ['Invalid login credentials. Please try again.']
    end
  end

end
