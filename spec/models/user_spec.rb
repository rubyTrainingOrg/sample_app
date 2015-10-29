require 'spec_helper'

describe User do
  before(:each) do
    @attr = { :nom => "Name example", :email => "Email example" }
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
end
