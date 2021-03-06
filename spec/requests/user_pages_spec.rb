require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('SIGN UP') }
    it { should have_title(full_title('SIGN UP')) }
  end

  describe "Profile Pages" do
  	let(:user) {FactoryGirl.create(:user)}

  	before {visit user_path(user)}

  	it {should have_title(user.name)}
  	it {should have_content(user.name)}
  end

  describe "sign up" do
  	before {visit signup_path}

  	let(:submit) {"Create my Account"}

  	describe "With invalid information" do
  		it "should not create a user" do
  			expect {click_button submit}.not_to change(User, :count)
  		end
  	end

  	describe "with valid information" do
  		before do
  			fill_in "Name", with: "Tanveer Ahmad Khan"
  			fill_in "Email", with: "tnvr000@gmail.com"
  			fill_in "Password", with: "foobar"
  			fill_in "Confirmation", with: "foobar"
  		end

  		it "should create a user" do
  			expect {click_button submit}.to change(User, :count)
  		end
  	end
  end


end