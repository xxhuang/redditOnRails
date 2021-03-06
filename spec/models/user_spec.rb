require 'spec_helper'

describe User do



  before { @user = User.new(email: "testemail@test.com", password: "password", password_confirmation: "password") }

  subject { @user }

  it { should respond_to(:email) }

  it { should be_valid }

  describe "when email format is invalid" do
    it "should be invalid" do
      email_addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      email_addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.sec@foo.jp a+b123@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end

  describe "when signup using a exist email address case1" do
    before do
      user_same_email = @user.dup
      user_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when signup using a exist email address case2" do
    before do
      user_same_email = @user.dup
      user_same_email.email = @user.email.upcase
      user_same_email.save
    end

    it { should_not be_valid }
  end


end