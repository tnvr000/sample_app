require 'spec_helper'

describe "Authentication" do
	subject {page}

	describe "Sign in page" do
		before {visit signin_path}

		it {should have_title('Sign In')}
		it {should have_content('Sign In')}
	end

	describe "Sign in " do
		before {visit signin_path}

		descriibe "with invalid information" do
			before {click_button "Sign In"}

			it {should have_title('Sign In')}
			it {should have_selector('div.alert.alert-danger')}
		end

		describe "with valid information" do
			let(:user) {FactoryGirl.create(:user)}

			before do
				fill_in "Email", with: user.email.upcase
				fill_in "password", with: user.password
				click_button "Sign In"
			end

			it {should have_title(user.name)}
			it {should have_link('Profile', href: user_path(user))}
			it {should have_link('Sign Out', href: signout_path)}
			it {should_not have_link('Sign In', href: signin_path)}
		end
		
		describe "after visiting another page" do
		  before { click_link "Home" }
		  it { should_not have_selector('div.alert.alert-error') }
		end
	end



end
