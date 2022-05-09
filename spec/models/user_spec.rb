require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it "is valid" do 
      user = User.create(name:'name',
      email:'test2@test.com',password:'password',password_confirmation:'password')
      expect(user).to be_valid
    end

    it 'email is missing' do 
      user = User.create(email:nil)
      expect(user).to be_invalid
      expect(user.errors[:email]).to include("can't be blank")

      user.email ='test@test.com'
      user.valid?
      expect(user.errors[:email]).not_to include("can't be blank")
    end

    it 'name is missing' do 
      user = User.create(name:nil)
      expect(user).to be_invalid
      expect(user.errors[:name]).to include("can't be blank")

      user.name ='test'
      user.valid?
      expect(user.errors[:name]).not_to include("can't be blank")
    end

    it "password don't match" do 
      user = User.create(name:'name',
      email:'test2@test.com',password:'password',password_confirmation:'pass')

      user.valid?
      expect(user.errors[:password_confirmation]).to be_present
    end

    it "email must be unique" do 
      user = User.create(name:'name',
      email:'test2@test.com',password:'password',password_confirmation:'password')

      user2 = User.create(name:'name',
      email:'test2@test.com',password:'password',password_confirmation:'password')

      expect(user2.errors[:email].first).to eq('has already been taken')
    end

    it "password length less than 5 characters is invalid" do 
      user = User.create(name:'name',
      email:'test2@test.com',password:'pass',
      password_confirmation:'pass')
      expect(user).to be_invalid
    end

    it "password length must be at-least 5 characters" do 
      user = User.create(name:'name',
      email:'test2@test.com',password:'passw',password_confirmation:'passw')
      expect(user).to be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should pass with valid credentials' do 
      User.create(name:'name',
      email:'test2@test.com',password:'passw',password_confirmation:'passw')

      user1 = User.authenticate_with_credentials('test2@test.com','passw')
      expect(user1).not_to be(nil)
    end

    it 'should not pass with invalid credentials' do 
      User.create(name:'name',
      email:'test2@test.com',password:'passw',password_confirmation:'passw')

      user1 = User.authenticate_with_credentials('test2@test.com','password')
      expect(user1).to be(nil)
    end

    it 'should pass even with spaces present in email' do 
      User.create(name:'name',
      email:'test2@test.com',password:'passw',password_confirmation:'passw')

      user1 = User.authenticate_with_credentials(' test2@test.com ','passw')
      expect(user1).not_to be(nil)
    end

    it 'should pass even with caps present in email' do 
      User.create(name:'name',
      email:'test2@test.com',password:'passw',password_confirmation:'passw')

      user1 = User.authenticate_with_credentials('tesT2@test.com','passw')
      expect(user1).not_to be(nil)
    end

  end

end