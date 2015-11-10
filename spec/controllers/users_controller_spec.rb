require 'spec_helper'

describe UsersController do
  render_views
  
  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end
    
    it "should have the right title" do
      get :new
      response.should have_selector("title", 
                                    :content => " | Inscription")
    end
  end
  
  describe "GET 'show'" do
    before(:each) do
      @user = Factory(:user)
    end
    
    it "devrait reussir" do
      get :show, :id => @user
      response.should be_success
    end
    
    it "devrait trouver le bon utilisateur" do
      get :show, :id => @user
      # La méthode assigns prend un argument symbolique (ici :user) et retourne la valeur qu'a la variable d'instance correspondante (ici @user)
      assigns(:user).should == @user
    end
    
    it "devrait avoir le bon titre" do
      get :show, :id => @user
      response.should have_selector("title", :content => @user.nom)
    end
    
    it "devrait inclure un h1 avec le nom de l'utilisateur" do
      get :show, :id => @user
      response.should have_selector("h1", :content => @user.nom)
    end
    
    it "devrait avoir une image de profil" do
      get :show, :id => @user
      response.should have_selector("h1>img", :class => "gravatar")
    end
  end
  
  describe "POST 'create'" do
    describe "echec" do
      before(:each) do
        @attr = { :nom => "", :email => "", :password => "",
                  :password_confirmation => "" }
      end
      
      it "ne devrait pas créer d'utilisateur" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end
      
      it "devrait avoir le bon titre" do
        post :create, :user => @attr
        response.should have_selector("title", :content => " | Inscription")
      end
      
      it "devrait rendre la page new" do
        post :create, :user => @attr
        response.should render_template('new')
      end
    end
    
    describe "success" do
      before(:each) do
        @attr = { :nom => "my name", 
                  :email => "email@valid.com", 
                  :password => "valid password",
                  :password_confirmation => "valid password" }
      end
      
      it "devrait créer un utilisateur" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end
      
      it "devrait rediriger vers la fiche de l'utilisateur" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end
      
      it "devrait afficher un message flash de bienvenue" do
        post :create, :user => @attr
        flash[:success].should =~ /Bienvenue dans l'Application Exemple/i
      end
    end
  end  
end
