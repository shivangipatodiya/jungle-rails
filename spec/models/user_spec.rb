require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.create(name: "Harry", email: "harry@1.com", password:"apple", password_confirmation:"apple")
  end

  describe "Validations" do
    it "should have the password matching with password_confirmation" do
      @user.password = 'apple'
      @user.password_confirmation = 'aaple'
      expect(@user).to_not be_valid
    end

    it "should not let a user be created without a password or password_confirmation" do
      @user.password = nil
      @user.password_confirmation = nil
      expect(@user).to_not be_valid
    end

    it "should have a unique email" do
        duplicate_user = @user.dup
        duplicate_user.email = @user.email.upcase
        expect(duplicate_user).to_not be_valid
      end
   

    it "should not let a product be created without an email" do
      @user.email = nil
      expect(@user).to_not be_valid
    end

    it "should not let a product be created without a name" do
      @user.name = nil
      expect(@user).to_not be_valid
    end

    it "should not let a product be created without a password_digest" do
      @user.password_digest = nil
      expect(@user).to_not be_valid
    end
    

    it "should have a password with minimum length of 5 characters" do
      @user.password_digest = "123"
      expect(@user).to_not be_valid
      @user.password_digest = "1234243"
      expect(@user).to be_valid
    end

  end

  describe '.authenticate_with_credentials' do
    context "given a correct user email with wrong password" do
      it "returns nil" do
        email = "harry@1.com"
        password = "aple"
        expect(@user.authenticate_with_credentials(email, password)).to eq(nil)
      end
    end

    context "given a wrong email" do
      it "returns nil" do
        email = "rry@1.com"
        password = "apple"
        expect(@user.authenticate_with_credentials(email, password)).to eq(nil)
      end
    end

    context "given a few white spaces in the correct user email string" do
      it "returns a user with that email without white spaces" do
        email = "  harry@1.com "
        password = "apple"
        expect(@user.authenticate_with_credentials(email, password)).to eq(@user)
      end
    end

    context "given a correct user email with wrong case" do
      it "returns user with that email" do
        email = "HArry@1.com"
        password = "apple"
        expect(@user.authenticate_with_credentials(email, password)).to eq(@user)
      end
    end

  end

end
