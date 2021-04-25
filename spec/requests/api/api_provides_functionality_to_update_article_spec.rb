RSpec.describe "PUT /api/articles/:id", type: :request do
  let!(:article) { create(:article, title: "This is the latest news", body: "And this is some mind blowing content") }

  describe "the happy path" do
    let(:user) { create(:user)  }
    let(:user_credentials) { user.create_new_auth_token }
    before do
      put "/api/articles/#{article.id}",
          params: {
            article: {
              title: "Updated Title - Happy Birthday",
              body: "And this is some mind blowing content",
            }
          },
      headers: user_credentials
    end

    it "is expected to respond with 202" do
      expect(response).to have_http_status 202
    end

    it "is expected to respond with success message" do
      expect(JSON.parse(response.body)["message"])
      .to eq "Your article is successfully updated"
    end

    it "is expected to respond with success message" do
      expect(JSON.parse(response.body)["article"]["title"])
      .to eq "Updated Title - Happy Birthday"
    end
  end
end
