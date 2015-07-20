require 'spec_helper'

describe User do

  it 'can be created' do
    user = create :user
    expect(user).to_not be_nil
  end

  it 'can update password' do
    user = create :user
    user.password = 'new_password'
    expect(user.valid?).to be true
  end

  it 'cannot update when password shorter than 8 characters' do
    user = create :user
    user.password = 'test'
    expect(user.valid?).to be false
  end

  it 'cannot create when password shorter than 8 characters' do
    user_hash = attributes_for(:user)
    user_hash[:password] = 'test'
    user = User.new user_hash
    expect(user.valid?).to be false
  end

  [:email, :password].each do |param|

    it "is not valid without param '#{param}'" do
      user_hash = attributes_for(:user)
      user_hash.delete param
      user = User.new user_hash
      expect(user.valid?).to be false
    end

  end

  it 'is not valid with duplicate email' do
    email = create(:user).email
    user_hash = attributes_for :user
    user_hash[:email] = email
    user = User.new user_hash
    expect(user.valid?).to be false
  end

  %w(garbage garbage@ @test).each do |invalid_email|

    it "is not valid with email #{invalid_email}" do
      user_hash = attributes_for(:user)
      user_hash[:email] = invalid_email
      user = User.new user_hash
      expect(user.valid?).to be false
    end

  end

end
