require 'spec_helper'

describe "LayoutLinks" do

  it "devrait trouver une page Accueil à '/'" do
    get '/'
    response.should have_selector('title', :content => "Accueil")
  end

  it "devrait trouver une page Contact at '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => "Contact")
  end

  it "should have an À Propos page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => "About")
  end

  it "devrait trouver une page Aide à '/help'" do
    get '/help'
    response.should have_selector('title', :content => "Help")
  end
  
  it "devrait avoir le bon lien sur le layout" do
      visit root_path
      click_link "À Propos"
      response.should have_selector('title', :content => "About")
      click_link "Aide"
      response.should have_selector('title', :content => "Help")
      click_link "Contact"
      response.should have_selector('title', :content => "Contact")
      click_link "Accueil"
      response.should have_selector('title', :content => "Accueil")
      click_link "S'inscrire !"
      response.should have_selector('title', :content => "Inscription")
  end
    
  describe "quand pas identifié" do
    it "devrait avoir un lien de connexion" do
        visit root_path
        response.should have_selector("a", :href => signin_path, 
                                            :content => "identifier")
    end
  end
    
  describe "quand identifié" do
    before(:each) do
      @user = Factory(:user)
      visit signin_path
      fill_in "eMail", :with => @user.email
      fill_in "Mot de passe", :with => @user.password
      click_button
    end
      
    it "devrait avoir un lien de déconnexion" do
      visit root_path
      response.should have_selector("a", :href => signout_path, 
                                          :content => "Déconnexion")
    end
      
    it "devrait avoir un lien vers le profil" do
      visit root_path
      response.should have_selector("a", :href => user_path(@user), 
                                            :content => "Mon profil")
    end
  end
end