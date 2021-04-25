RSpec.describe "POST api/auth/sign_in", type: :request do
  
  describe 'successfully' do
    let(:user) { create(:user)  }
    let(:user_credentials) { user.create_new_auth_token }
    before do
      post '/api/articles',
      params:{
        article: {
          title: 'This is a new article',
          body: 'With some brand new content'
        }
      },
      headers: user_credentials      
    end

    it 'is expected to return 201 status' do
      expect(response).to have_http_status 201
    end

    it "is expected to respond with success message" do      
      expect(JSON.parse(response.body)["article"]["title"])
      .to eq 'This is a new article'
    end

    it "is expected to respond with success message" do
      expect(JSON.parse(response.body)["article"]["body"])
      .to eq 'With some brand new content'
    end
  end

  describe 'unsuccessfully, no headers' do
    let(:user) { create(:user)  }
    let(:user_credentials) { user.create_new_auth_token }
    before do
      post '/api/articles',
      params:{
        article: {
          title: 'This is a new article',
          body: 'With some brand new content'
        }
      }
      #headers: 'wrong_token'
    end

    it 'is expected to return 401 status' do      
      expect(response).to have_http_status 401
    end

    it "is expected to respond with success message" do
      expect(response_json["errors"].to_sentence)
      .to eq 'You need to sign in or sign up before continuing.'
    end
  end
end