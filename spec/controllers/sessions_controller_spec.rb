describe SessionsController, :omniauth do

  before do
    request.env['omniauth.auth'] = auth_mock
  end

  describe "#create" do
    it "creates a player" do
      expect {post :create, provider: :twitter}.to change{ Player.count }.by(1)
    end

    it "creates a session" do
      expect(session[:player_id]).to be_nil
      post :create, provider: :twitter
      expect(session[:player_id]).not_to be_nil
    end
  end

  describe "#destroy" do
    before do
      post :create, provider: :twitter
    end

    it "resets the session" do
      expect(session[:player_id]).not_to be_nil
      delete :destroy
      expect(session[:player_id]).to be_nil
    end

    it "redirects to the home page" do
      delete :destroy
      expect(response).to redirect_to root_url
    end
  end

end
