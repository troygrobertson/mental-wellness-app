require 'spec_helper'

describe User do
  #create user object name user
  before { @user = User.new(name: "Example User", email: "user@example.com",password: "foobar", password_confirmation: "foobar"
               )}
  #check variable are responding 
  subject {@user}
  it { should respond_to(:name)}
  it { should respond_to(:email)}
  it { should respond_to(:crypted_password)}
  it {should respond_to(:password)}
  it { should respond_to(:password_confirmation)}
  it { should respond_to(:password_salt)}
  it { should respond_to(:persistence_token)}
#	it {should be_valid}
  it {should respond_to(:verified)}
  it {should respond_to(:perishable_token)}
  it {should respond_to(:institutions)}
  it {should have_many(:institution_memberships)}
  it {should have_many(:institutions)}

  it "has a valid profile" do
    FactoryGirl.build(:user, profile_type: nil).should_not be_valid
  end

  it "has a valid admin profile" do
    FactoryGirl.build(:userAdmin).should be_valid
  end

  it "has a valid doctor profile" do
    FactoryGirl.build(:userDoctor).should be_valid
  end

  it "has a valid patient profile" do
      FactoryGirl.build(:userPatient).should be_valid
  end

=begin
	#check user is invalid without a name
	it "is invalid without a name" do 
		build(:user, name: nil).should_not be_valid
	end 
	#check user is invalid without a email
	it "is invalid without a email" do
		build(:user, email: nil).should_not be_valid
	end
	#check user is invalid without a pw
	it "is invalid without a pw" do
		build(:user, password: nil).should_not be_valid
	end
	#check user is invalid without a pwConf
	it "is invalid without a pwConf" do
		build(:user, password_confirmation: nil).should_not be_valid
	end
	
	#check user is invalid with an invalid email
	it "when email format is invalid" do
		build(:user, email: "user@foo,com").should_not be_valid
		build(:user, email: "user_at_foo.org").should_not be_valid
		build(:user, email: "example.user@foo.").should_not be_valid
	end
		
	#check user is valid with a valid email
	it "when email format is valid" do
		build(:user, email: "user@foo.COM").should be_valid
		build(:user, email: "A_US-ER@f.b.org").should be_valid
		build(:user, email: "frst.lst@foo.jp").should be_valid
		build(:user, email: "a+b@baz.cn").should be_valid
	
	end
	
	#check user can only have a unique email
	it "when email address is already taken" do
		create(:user, email: "foo@gmail.com")
		build(:user, email: "foo@gmail.com").should_not be_valid
	end
	
	#check user is invalid without pw
	it "when password is not present" do
		build(:user, password: " ", password_confirmation: " ").should_not be_valid
	end

	#check user is invalid without matching pw
	it "when password does not match confirmation" do
		build(:user, password:"foobar", password_confirmation: "barfoo").should_not be_valid
	end
	
	#check user is invalid with to sort pw
	it "with a password that is to short" do
		build(:user, password: "foo00", password_confirmation: "foo00").should_not be_valid
	end
	#check user is valid with appropriate length email
	it "with a password that is not to short" do
		build(:user, password: "foo000", password_confirmation: "foo000").should be_valid
	end
	
	
	describe"return value of the authenticate method" do
		#test authentication with invalid pw
		it "with valid password" do
			testUser = create(:user, password: "foobar",password_confirmation:"foobar")
			testUser.authenticate("foobar").should be_true
		end
		#test authentication with valid pw
		it "with valid password" do
			testUser = create(:user, password: "foobar",password_confirmation:"foobar")
			testUser.authenticate("notfoobar").should_not be_true
		end
		
	end
	#test remember token is lost
	it "removes remember token" do
		testUser = create(:user)
		testUser.remember_token{should_not be_blank}
		
=end end
end
