require 'spec_helper'

describe User do
  before(:each) do
    @attr = { 
      :nom => "Name example", 
      :email => "email@example.com",
      :password => "password",
      :password_confirmation => "password",
    }
  end
  
  it "devrait creer une instance valide" do
    User.create!(@attr)
  end
  
  it "devrait exiger un nom" do
    bad_guy = User.new(@attr.merge( :nom => ""))
    bad_guy.should_not be_valid
  end
  
  it "devrait exiger un email" do
    no_mail_guy = User.new(@attr.merge( :email => ""))
    no_mail_guy.should_not be_valid
  end
  
  it "devrait refuser les noms trop longs" do
    long_nom = "a"*51
    long_nom_guy = User.new(@attr.merge( :nom => long_nom))
    long_nom_guy.should_not be_valid
  end
  
  it "devrait accepter les adresses email valides" do
    addresses = %w[user@foo.com THE_foo@bar.com foo.bar@foo.com]
    addresses.each do |address|
      valid_mail_guy = User.new(@attr.merge( :email => address))
      valid_mail_guy.should be_valid
    end
  end
  
  it "devrait refuser les adresses email invalides" do
    addresses = %w[user@foo,com THE_foo_bar.com foo.bar.foo.com]
    addresses.each do |address|
      not_valid_mail_guy = User.new(@attr.merge( :email => address))
      not_valid_mail_guy.should_not be_valid
    end
  end
  
  it "devrait rejeter un doublon d'emails" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  it "devrait rejeter une adresse email invalide niveau casse" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_upcased_email = User.new(@attr)
    user_with_upcased_email.should_not be_valid
  end
  
  describe "password validations" do
  
    it "devrait exiger un mot de passe " do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
    end
    
    it "devrait exiger une confirmation de mot de passe qui soit identique au mot de passe " do
      User.new(@attr.merge(:password_confirmation => "another_password")).should_not be_valid
    end
    
    it "devrait refuser les mots de passe trop courts" do
      short_password = "a"*5
      hash = @attr.merge(:password => short_password, :password_confirmation => short_password)
      User.new(hash).should_not be_valid
    end
    
    it "devrait refuser les mots de passe trop longs" do
      long_password = "a"*41
      hash = @attr.merge(:password => long_password, :password_confirmation => long_password)
      User.new(hash).should_not be_valid
    end
  end
  
  describe "password encryption" do
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "devrait avoir un attribut mot de passe encrypté" do
      @user.should respond_to(:encrypted_password)
    end
    
    it "devrait définir le mot de passe crypté" do
      @user.encrypted_password.should_not be_blank
    end
    
    describe "methode has_password?" do
      
      it "devrait retourner true si les mots de passe coincoident" do
        @user.has_password?(@attr[:password]).should be_true
      end
      
      it "devrait retourner false si les mots de passe divergent" do
        @user.has_password?("another_password").should be_false
      end
    end
    
    describe "authenticate method" do
      it "devrait retourner nil en cas d'inéquation entre email/mot de passe" do
        wrong_password_user = User.authenticate(@attr[:email],"wrong_password")
        wrong_password_user.should be_nil
      end
      
      it "devrait retourner nil quand un email ne correspond à aucun utilisateur" do
        non_existent_user = User.authenticate("wrong@user.com",@attr[:password])
        non_existent_user.should be_nil
      end
      
      it "devrait retourner l'utilisateur si email/mot de passe correspondent" do
        valid_user = User.authenticate(@attr[:email],@attr[:password])
        valid_user.should == @user
      end
    end
  end
end
