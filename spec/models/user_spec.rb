require 'spec_helper'

describe User do

  describe "validates data" do
    subject { User.new(@valid_attributes)}

    it { should     accept_values_for(:email, "john@example.com", "lambda@gusiev.com") }
    it { should_not accept_values_for(:email, "invalid", nil, "a@b", "john@.com") }
  end

  it "can authenticate with right mail + password" do
    u1 = User.create!( :name => "dummy", :email => "foo@bar.com", :password => "geheim" )
    u2 = u1.authenticate("geheim" )
    u2.should_not be_nil
    u1.id.should eql(u2.id)
  end

  it "cannot authenticate with wrong password" do
    u1 = User.create!( :name => "dummy", :email => "foo@bar.com", :password => "geheim" )
    u2 = User.authenticate( "foo@bar.com", "falsch" )
    u2.should be_nil
  end

  it "encrypts the password" do
    u1 = User.new( :name => "dummy", :email => "foo@bar.com", :password => "geheim" )
    u1.save
    u2 = User.find_by_email("foo@bar.com")
    u2.password_digest.should_not be_nil
    u2.password_digest.should_not eql(u1.password)
    u2.password.should be_nil
  end

end
