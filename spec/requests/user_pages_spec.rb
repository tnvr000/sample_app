require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('SIGN UP') }
    it { should have_title(full_title('SIGN UP')) }
  end
end