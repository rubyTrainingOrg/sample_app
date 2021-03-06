require 'spec_helper'

describe "Users" do
  describe "Une inscription" do
    describe "ratée" do
      it "ne devrait pas créer un nouvel utilisateur" do
        lambda do
          visit signup_path
          fill_in "Nom", :with => ""
          fill_in "eMail", :with => ""
          fill_in "Password", :with => ""
          fill_in "Confirmation", :with => ""
          click_button
          response.should render_template('users/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(User, :count)
      end
    end
    describe "réussie" do
      it "devrait créer un nouvel utilisateur" do
        lambda do
          visit signup_path
          # dans la prochaine ligne on peut utiliser "Nom" (label du champ) ou :user_nom (nom HTML du champ)
          fill_in :user_nom, :with => "my name"
          fill_in "eMail", :with => "email@valid.com"
          fill_in "Password", :with => "valid password"
          fill_in "Confirmation", :with => "valid password"
          click_button
          response.should render_template('users/show')
          response.should have_selector("div.flash.success", :content => "Bienvenue")
        end.should change(User, :count).by(1)
      end
    end
    
  end
  
  describe "identification/déconnexion" do
    describe "une mauvaise identification" do
      it "ne devrait pas identifier l'utilisateur" do
        visit signin_path
        fill_in "eMail", :with => ""
        fill_in "Mot de passe", :with => ""
        click_button
        response.should have_selector("div.flash.error", :content => "invalid")
      end
    end
    
    describe "une identification valide" do
      before(:each) do
        @user = Factory(:user)
      end
      it "devrait identifier l'utilisateur" do
        visit signin_path
        fill_in "eMail", :with => @user.email
        fill_in "Mot de passe", :with => @user.password
        click_button 
        controller.should be_signed_in
        click_link "Déconnexion"
        controller.should_not be_signed_in
      end
    end
  end
end
