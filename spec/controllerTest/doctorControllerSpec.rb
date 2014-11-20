require 'spec_helper'


#RSpec.describe User do
describe DoctorsController, type: :controller do
 
	describe "index" do
		it "populates an array of users" do
			person = create(:doctor)
			puts person.user.name
			get :index
			assigns(:doctor).should eq([person])
		end
		it "renders the: index view" do 
			get :index
			response.should render_template :index
		end
	end
 
	describe "show" do
		it "assigns the request user to @user" do
			user = create(:doctor)
			get :show, id: user.id
			assigns(:doctor).should eq(user)
		end
		it "rends show view" do
			user = create(:doctor)
			get :show, {'id' => "1"}
			response.should render_template :show
		end
	end
 
	describe "new" do
		it "assigns a new user to @user" do
			get :new
			expect(assigns(:doctor)).to be_a_new(Admin)
		end
		it "renders the : new template" do
			get :new
			response.should render_template :new
		end 
	end 


	describe "create" do
		context "valid attributes" do
		
			it "create new contact" do
				@user = create(:user)	
				expect{post :create, admin: attributes_for(:doctor), user: @user}.to change(Admin, :count).by(1)
			end
			it "redirects to the home page" do
				@user = create(:user)	
				post :create, admin: attributes_for(:doctor), user: @user
				response.should redirect_to Admin.last
			end
		end
		context "invalid attributes" do
		
			it "create new contact" do
				expect{post :create, admin: attributes_for(:doctor), user: attributes_for(:userInvalid)}.to_not change(Admin, :count).by(1)
			end
			it "redirects to the home page" do
				post :create, admin: attributes_for(:doctor), user: attributes_for(:userInvalid)
				response.should render_template :new
			end
		end
	end

	describe "edit" do
		it "request user to @user" do
			user = create(:doctor)
			get :edit, {'id' => "1"}
			assigns(:doctor).should eq(user)
		end
		it "rends show view" do
			user = create(:doctor)
			get :edit, {'id' => "1"}
			response.should render_template :edit
		end
		
	end

	describe "update" do
	
		context "valid attribute" do 
			it "locate requested @user" do
				@user = create(:doctor)
				put :update, id: @user, user: FactoryGirl.attributes_for(:doctor)
		
			end
			it "changes user attributes" do
				@user = create(:doctor)
				nameUser = @user.user.name
				emailUser = @user.user.email
				passwordUser = @user.user.password
				put :update, id: @user, user: FactoryGirl.attributes_for(:user, name:"Bob", email:"something@gmail.com", password:"barfoo",password_confirmation:"barfoo")
				@user.reload
				@user.user.name.should eq(nameUser)
				@user.user.email.should eq(emailUser)
				@user.user.password.should eq(passwordUser)
				@user.user.password_confirmation.should eq(passwordUser)
				response.should redirect_to @user
			end
		end
		context "invalid attributes" do
			it "doesnt changes attribute" do
				@user = create(:doctor)	
				nameUser = @user.user.name
				emailUser = @user.user.email
				passwordUser = @user.user.password			
				put :update, id: @user, user: FactoryGirl.attributes_for(:user, name:"Bob", email:"somethinggmail.com", password:"barfoo",password_confirmation:"barfoo")
				@user.reload
				@user.user.name.should eq(nameUser)
				@user.user.email.should eq(emailUser)
				@user.user.password.should eq(passwordUser)
				@user.user.password_confirmation.should eq(passwordUser)
				@user.user.name.should_not eq("Bob")
				@user.user.password.should_not eq("barfoo")
				@user.user.password_confirmation.should_not eq("barfoo")
			end
			it "doesnt changes attribute" do
				user = create(:doctor)	
				nameUser = @user.user.name
				emailUser = @user.user.email
				passwordUser = @user.user.password
				put :update, id: @user, user: FactoryGirl.attributes_for(:doctor, name:nil, email:"something@gmail.com", password:"barfoo",password_confirmation:"barfoo")
				@user.reload
				@user.user.name.should eq(nameUser)
				@user.user.email.should eq(emailUser)
				@user.user.password.should eq(passwordUser)
				@user.user.password_confirmation.should eq(passwordUser)
				@user.user.email.should_not eq("something@gmail.com")
				@user.user.password.should_not eq("barfoo")
				@user.user.password_confirmation.should_not eq("barfoo")
			end
			it "doesnt changes attribute" do
				user = create(:doctor)	
				nameUser = @user.user.name
				emailUser = @user.user.email
				passwordUser = @user.user.password
				put :update, id: @user, user: FactoryGirl.attributes_for(:doctor, name:"Bob", email:"something@gmail.com", password:"bar",password_confirmation:"bar")
				@user.reload
				@user.user.name.should eq(nameUser)
				@user.user.email.should eq(emailUser)
				@user.user.password.should eq(passwordUser)
				@user.user.password_confirmation.should eq(passwordUser)	
				@user.user.name.should_not eq("Bob")
				@user.user.email.should_not eq("something@gmail.com")
				@user.user.password.should_not eq("bar")
				@user.user.password_confirmation.should_not eq("bar")
			end
			it "doesnt changes attribute" do
				user = create(:doctor)	
				nameUser = @user.user.name
				emailUser = @user.user.email
				passwordUser = @user.user.password
				put :update, id: @user, user: FactoryGirl.attributes_for(:doctor, name:nil, email:"something@gmail.com", password:"barfo1",password_confirmation:"barfoo")
				@user.reload
				@user.user.name.should eq(nameUser)
				@user.user.email.should eq(emailUser)
				@user.user.password.should eq(passwordUser)
				@user.user.password_confirmation.should eq(passwordUser)
				@user.user.name.should_not eq("Bob")
				@user.user.email.should_not eq("something@gmail.com")
				@user.user.password.should_not eq("barfo1")
				@user.user.password_confirmation.should_not eq("barfoo")
			end
			it "doesnt changes attribute" do
				user = create(:doctor)	
				nameUser = @user.user.name
				emailUser = @user.user.email
				passwordUser = @user.user.password
				put :update, id: @user, user: FactoryGirl.attributes_for(:doctor, name:nil, email:"something@gmail.com", password:nil,password_confirmation:"barfoo")
				@user.reload
				@user.user.name.should eq(nameUser)
				@user.user.email.should eq(emailUser)
				@user.user.password.should eq(passwordUser)
				@user.user.password_confirmation.should eq(passwordUser)
				@user.user.email.should_not eq("something@gmail")
				@user.user.name.should_not eq("Bob")
				@user.user.password_confirmation.should_not eq("barfoo")
			end
			it "doesnt changes attribute" do
				user = create(:doctor)	
				nameUser = @user.user.name
				emailUser = @user.user.email
				passwordUser = @user.user.password
				put :update, id: @user, user: FactoryGirl.attributes_for(:doctor, name:nil, email:"something@gmail.com", password:"barfoo",password_confirmation:nil)
				@user.reload
				@user.user.name.should eq(nameUser)
				@user.user.email.should eq(emailUser)
				@user.user.password.should eq(passwordUser)
				@user.user.password_confirmation.should eq(passwordUser)
				@user.user.email.should_not eq("something@gmail")
				@user.user.password.should_not eq("barfoo")
				@user.user.name.should_not eq("Bob")
			end
			it "re-renders the edit method" do
				user = create(:doctor)
				put :update, id: @user, user: FactoryGirl.attributes_for(:doctor, name:nil, email:"something@gmail.com", password:"barfoo",password_confirmation:nil)
				response.should render_template :edit
			end
		end
	end

	describe "delete method" do
		it "deletes user" do
			@user = create(:doctor)
			expect{delete :destroy, id: @user}.to change(User,:count).by(-1)
		end
		it "redirect to users" do
			@user = create(:doctor)
			delete :destroy, id: @user
			response.should redirect_to user
		end
	end

end