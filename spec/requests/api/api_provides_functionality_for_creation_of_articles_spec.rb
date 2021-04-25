RSpec.describe "POST /api/articles", type: :request do
  
  describe "the happy path" do
    let(:user) { create(:user)  }
    let(:user_credentials) { user.create_new_auth_token }
    before do
      post '/api/articles', params: { 
        article: { 
          title: 'Not so fun with Node', 
          body: 'it is a configuration hell' 
        } 
      },
      headers: user_credentials
    end

    it 'is expected to respond with 201' do
      expect(response).to have_http_status 201
    end

    it 'is expected to respond with success message' do
      expect(JSON.parse(response.body)['message']).to eq 'Your article is successfully created'
    end
  end

  describe 'the sad path' do
    let(:user) { create(:user)  }
    let(:user_credentials) { user.create_new_auth_token }
    before do
      post '/api/articles', params: { 
        article: { 
          title: '', 
          body: 'it is a configuration hell' 
        } 
      },
      headers: user_credentials
    end

    it 'is expected to respond with 422' do
      expect(response).to have_http_status 422
    end

    it 'is expected to respond with error message' do
      expect(JSON.parse(response.body)['message']).to eq 'Title can\'t be blank'
    end
  end
end