require 'spec_helper'

describe SessionsController do
  render_views
  
  describe "GET 'new'" do
    
    it "devrait réussir" do
      get :new
      response.should be_success
    end
    
    it "devrait avoir le bon titre" do
      get :new
      response.should have_selector("title", 
                                    :content => "identifier")
    end
  end
  
  describe "POST 'create'" do
    describe "avec creds invalides" do
      before(:each) do
        @attr = { :email => "email@example.com", :password => "invalid" }
      end
      
      it "devrait re-rendre la page new" do
        post :create, :session => @attr
        response.should render_template('new') 
      end
      
      it "devrait avoir le bon titre" do
        post :create, :session => @attr
        response.should have_selector("title", :content => "identifier") 
      end
      
      it "devrait avoir un message flash.now" do
        post :create, :session => @attr
        flash.now[:error].should =~ /invalid/i
      end
    end
    
    describe "avec email/mot de passe valides" do
      before(:each) do
        @user = Factory(:user)
        @attr = { :email => @user.email, :password => @user.password }
      end
      
      it "devrait identifier l'utilisateur" do
        post :create, :session => @attr
        controller.current_user.should == @user
        # la prochaine ligne est équivalente à controller.signed_in?.should be_true
        controller.should be_signed_in
      end
      
      it "devrait rediriger vers la page de l'utilisateur" do
        post :create, :session => @attr
        response.should redirect_to(user_path(@user))
      end
    end
  end
  
  describe "DELETE 'destroy'" do
    
    it "devrait déconnecter l'utilisateur" do
      test_sign_in(Factory(:user))
      delete :destroy
      controller.should_not be_signed_in
    end
    
    it "devrait rediriger vers la page d'accueil" do
      test_sign_in(Factory(:user))
      delete :destroy
      controller.should redirect_to(root_path)
    end
    
  end
  
end
