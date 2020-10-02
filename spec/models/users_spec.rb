require 'rails_helper'

RSpec.describe Users, type: :model do

  it 'is pass user registration' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'is invalid without a nickname' do
    user = build(:user, nickname: '')
    user.valid?
    expect(user.errors[:nickname]).to include("can't be blank")
  end

  it 'is invalid too long  a nickname' do
    user = build(:user, nickname: '1234567890abcdefghijklmn')
    user.valid?
    expect(user.errors[:nickname]).to include("is too long (maximum is 20 characters)")
  end

  it 'is invalid without an email' do
    user = build(:user, email: '')
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it 'is invalid with an email wrong format' do
    user = build(:user, email: '')
    user.valid?
    expect(user.errors[:email]).to include("is invalid")
  end

  it 'is invalid without a password' do
    user = build(:user, password: '')
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  it 'is invalid without a password_confirmation' do
    user = build(:user, password_confirmation: '')
    user.valid?
    expect(user.errors[:password_confirmation]).to include("can't be blank")
  end
  
  it 'is invalid with a password wrong format' do
    user = build(:user, password: 'aaaaaaaaaaa',password_confirmation: 'aaaaaaaaaaa')
    user.valid?
    expect(user.errors[:password]).to include("is invalid")
  end

  it 'is invalid not match password and password_confirmation' do
    user = build(:user, password: 'aaaaaaaaa22',password_confirmation: 'bbbbbbbb22')
    user.valid?
    expect(user.errors[:password_confirmation]).to include("doesn't match Password")
  end

  it 'is invalid too long a password' do
    user = build(:user, password: 'testtoolong128testtesttoolong128testtesttoolong128testtesttoolong128testtesttoolong128testtesttoolong128testtesttoolong128testtesttoolong128testtesttoolong128testtesttoolong128testtesttoolong128testtesttoolong128testtesttoolong128testtesttoolong128testtesttoolong128testtesttoolong128testtesttoolong128test')
    user.valid?
    expect(user.errors[:password]).to include("is too long (maximum is 128 characters)")
  end

  it 'is invalid too short a password' do
    user = build(:user, password: 'test')
    user.valid?
    expect(user.errors[:password]).to include("is too short (minimum is 7 characters)")
  end

end
