require 'rails_helper'

RSpec.describe User, type: :model do
  describe  'Validations' do
    # before(:all) do
    # end

    context 'passwords' do
      it "should save matching passwords successfully" do
        @user = User.new(
          :name => 'Test user name',
          :email => 'test@test.com',
          :password => 'testpassword',
          :password_confirmation => 'testpassword'
        )
        expect(@user.valid?).to be true
        expect(@user.errors.full_messages).not_to be_present
      end
      it "should not save if passwords don't match" do
        @user = User.new(
          :name => 'Test user name',
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
          :name => 'Test user name',
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
        @user1 = User.new(:name => 'Test user1 name', :email => 'test@test.com', :password => 'testpassword', :password_confirmation => 'testpassword')
        @user1.save

        @user2 = User.new(
          :name => 'Test user2 name',
          :email => 'test@test.com', # already used email
          :password => 'testpassword',
          :password_confirmation => 'testpassword'
        )
        expect(@user2.valid?).to be false
        expect(@user2.errors.full_messages).to include("Email has already been taken")
      end
    end

    # context 'email, first name, last name' do
    #   it "should be required" do
    #     @user = User.new(
    #       # :name => 'Test user name',
    #       # :email => 'test@test.com',
    #       :password => 'testpassword',
    #       :password_confirmation => 'testpassword'
    #     )
    #     expect(@user.valid?).to be false
    #     expect(@user.errors.full_messages).to include("Email has already been taken")
    #   end
    # end

    # p "_______________begin"
    # p @user
    # p @user.errors[:password_confirmation]
    # p "______________end!"

  end
end
