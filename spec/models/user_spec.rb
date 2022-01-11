require 'rails_helper'

RSpec.describe User, type: :model do
  describe  'Validations' do
    # before(:all) do
    # end

    context 'password presence' do
      it "should save matching passwords successfully" do
        @user = User.new(
          :first_name => 'firstname',
          :last_name => 'lastname',
          :email => 'test@test.com',
          :password => 'testpassword',
          :password_confirmation => 'testpassword'
        )
        expect(@user.valid?).to be true
        expect(@user.errors.full_messages).not_to be_present
      end
      it "should not save if passwords don't match" do
        @user = User.new(
          :first_name => 'firstname',
          :last_name => 'lastname',
          :email => 'test@test.com',
          :password => 'testpassword',
          :password_confirmation => 'nottestpassword'
        )
        expect(@user.valid?).to be false
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        # expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
      end
      it "should not save if missing password" do
        @user = User.new(
          :first_name => 'firstname',
          :last_name => 'lastname',
          :email => 'test@test.com',
          :password => 'testpassword',
          :password_confirmation => ''
        )
        expect(@user.valid?).to be false
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        # expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
      end
    end

    context 'email' do
      it "should be unique" do
        @user1 = User.new(:first_name => 'firstname1', :last_name => 'lastname1', :email => 'test@test.com', :password => 'testpassword', :password_confirmation => 'testpassword')
        @user1.save

        @user2 = User.new(
          :first_name => 'firstname2',
          :last_name => 'lastname2',
          :email => 'test@test.com', # already used email
          :password => 'testpassword',
          :password_confirmation => 'testpassword'
        )
        expect(@user2.valid?).to be false
        expect(@user2.errors.full_messages).to include("Email has already been taken")
      end
    end

    context 'email, first name, last name' do
      it "should save successfully" do
        @user = User.new(:first_name => 'firstname', :last_name => 'lastname', :email => 'test@test.com', :password => 'testpassword', :password_confirmation => 'testpassword')
        expect(@user).to be_valid
      end
      it "should require email" do
        @user = User.new(:first_name => 'firstname', :last_name => 'lastname', :email => nil, :password => 'testpassword', :password_confirmation => 'testpassword')
        expect(@user).to be_invalid
        expect(@user.errors[:email]).to include("can't be blank")
      end
      it "should require first name" do
        @user = User.new(:first_name => nil, :last_name => 'lastname', :email => 'test@test.com', :password => 'testpassword', :password_confirmation => 'testpassword')
        expect(@user).to be_invalid
        expect(@user.errors[:first_name]).to include("can't be blank")
      end
      it "should require last name" do
        @user = User.new(:first_name => 'firstname', :last_name => nil, :email => 'test@test.com', :password => 'testpassword', :password_confirmation => 'testpassword')
        expect(@user).to be_invalid
        expect(@user.errors[:last_name]).to include("can't be blank")
      end
    end

    context 'password length' do
      it "should be invalid if 5 characters or less" do
        @user = User.new(:first_name => 'firstname', :last_name => 'lastname', :email => 'test@test.com', :password => '12345', :password_confirmation => '12345')
        expect(@user).to be_invalid
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "should be 6 characters or more" do
        @user = User.new(:first_name => 'firstname', :last_name => 'lastname', :email => 'test@test.com', :password => '123456', :password_confirmation => '123456')
        expect(@user).to be_valid
      end
    end

  end


  describe '.authenticate_with_credentials' do
    context 'authentication' do
      it "should pass with valid credentials" do
        @user = User.new(:first_name => 'firstname', :last_name => 'lastname', :email => 'test@test.com', :password => 'testpassword', :password_confirmation => 'testpassword')
        @user.save

        @existing_user = User.authenticate_with_credentials('test@test.com', 'testpassword')
        expect(@existing_user).not_to be(nil)
        # p @existing_user # => #<User id: ...>
      end
      it "should fail with invalid credentials" do
        @user = User.new(:first_name => 'firstname', :last_name => 'lastname', :email => 'test@test.com', :password => 'testpassword', :password_confirmation => 'testpassword')
        @user.save

        @existing_user = User.authenticate_with_credentials('test@test.com', 'invalidpassword')
        expect(@existing_user).to be(nil)
        # p @existing_user # => nil
      end
    end


  end

end
