require 'spec_helper'


#RSpec.describe User do
describe AdminsController, type: :controller do
=begin 	
	describe "index" do
		it "populates an array of users" do
			person = create(:admin)
			puts person.user.name
			get :index
			assigns(:admin).should eq([person])
		end
		it "renders the: index view" do 
			get :index
			response.should render_template :index
		end
	end
=end 
	describe "show" do
		it "assigns the request user to @user" do
			user = create(:admin)
			get :show, id: user.id
			assigns(:admin).should eq(user)
		end
		it "rends show view" do
			user = create(:admin)
			get :show, {'id' => "1"}
			response.should render_template :show
		end
	end
=begin 
	describe "new" do
		it "assigns a new user to @user" do
			get :new
			expect(assigns(:admin)).to be_a_new(Admin)
		end
		it "renders the : new template" do
			get :new
			response.should render_template :new
		end 
	end 


	describe "create" do
		context "valid attributes" do
		
			it "create new contact" do
				expect{post :create, admin: {name: "Joe", email: "me@gmail.com", password: "foobar", password_confirmation: "foobar"}}.to change(Admin, :count).by(1)
			end
			it "redirects to the home page" do
				post :create, admin: {name: "Joe", email: "me@gmail.com", password: "foobar", password_confirmation: "foobar"}
				response.should redirect_to Admin.last
			end
		end
		context "invalid attributes" do
		
			it "create new contact" do
				expect{post :create, admin: {name: "Joe", email: "megmail.com", password: "foobar", password_confirmation: "foobar"}}.to_not change(Admin, :count).by(1)
			end
			it "redirects to the home page" do
				post :create, admin: {name: "Joe", email: "megmail.com", password: "foobar", password_confirmation: "foobar"}
				response.should render_template :new
			end
		end
	end


	describe "edit" do
		it "request user to @user" do
			user = create(:admin)
			get :edit, {'id' => "1"}
			assigns(:admin).should eq(user)
		end
		it "rends show view" do
			user = create(:admin)
			get :edit, {'id' => "1"}
			response.should render_template :edit
		end
		
	end
=end

	describe "update" do
	
		context "valid attribute" do 
			it "locate requested @user" do
				@user = create(:admin)
				put :update, id: @user, user: FactoryGirl.attributes_for(:admin)
		
			end
			it "changes user attributes" do
				@user = create(:admin)
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
				@user = create(:admin, name: "Joe", email: "me@gmail.com", password: "foobar", password_confirmation: "foobar")
				put :update, id: @user, user: FactoryGirl.attributes_for(:admin, name:"Bob", email:"somethinggmail.com", password:"barfoo",password_confirmation:"barfoo")
				@user.reload
				@user.name.should eq("Joe")
				@user.email.should eq("me@gmail.com")
				@user.password.should eq("foobar")
				@user.password_confirmation.should eq("foobar")
				@user.name.should_not eq("Bob")
				@user.password.should_not eq("barfoo")
				@user.password_confirmation.should_not eq("barfoo")
			end
			it "doesnt changes attribute" do
				@user = create(:admin, name: "Joe", email: "me@gmail.com", password: "foobar", password_confirmation: "foobar")
				put :update, id: @user, user: FactoryGirl.attributes_for(:admin, name:nil, email:"something@gmail.com", password:"barfoo",password_confirmation:"barfoo")
				@user.reload
				@user.name.should eq("Joe")
				@user.email.should eq("me@gmail.com")
				@user.password.should eq("foobar")
				@user.password_confirmation.should eq("foobar")
				@user.email.should_not eq("something@gmail.com")
				@user.password.should_not eq("barfoo")
				@user.password_confirmation.should_not eq("barfoo")
			end
			it "doesnt changes attribute" do
				@user = create(:admin, name: "Joe", email: "me@gmail.com", password: "foobar", password_confirmation: "foobar")
				put :update, id: @user, user: FactoryGirl.attributes_for(:admin, name:"Bob", email:"something@gmail.com", password:"bar",password_confirmation:"bar")
				@user.reload
				@user.name.should eq("Joe")
				@user.email.should eq("me@gmail.com")
				@user.password.should eq("foobar")
				@user.password_confirmation.should eq("foobar")	
				@user.name.should_not eq("Bob")
				@user.email.should_not eq("something@gmail.com")
				@user.password.should_not eq("bar")
				@user.password_confirmation.should_not eq("bar")
			end
			it "doesnt changes attribute" do
				@user = create(:admin, name: "Joe", email: "me@gmail.com", password: "foobar", password_confirmation: "foobar")
				put :update, id: @user, user: FactoryGirl.attributes_for(:admin, name:nil, email:"something@gmail.com", password:"barfo1",password_confirmation:"barfoo")
				@user.reload
				@user.name.should eq("Joe")
				@user.email.should eq("me@gmail.com")
				@user.password.should eq("foobar")
				@user.password_confirmation.should eq("foobar")
				@user.name.should_not eq("Bob")
				@user.email.should_not eq("something@gmail.com")
				@user.password.should_not eq("barfo1")
				@user.password_confirmation.should_not eq("barfoo")
			end
			it "doesnt changes attribute" do
				@user = create(:admin, name: "Joe", email: "me@gmail.com", password: "foobar", password_confirmation: "foobar")
				put :update, id: @user, user: FactoryGirl.attributes_for(:admin, name:nil, email:"something@gmail.com", password:nil,password_confirmation:"barfoo")
				@user.reload
				@user.name.should eq("Joe")
				@user.email.should eq("me@gmail.com")
				@user.password.should eq("foobar")
				@user.password_confirmation.should eq("foobar")
				@user.email.should_not eq("something@gmail")
				@user.name.should_not eq("Bob")
				@user.password_confirmation.should_not eq("barfoo")
			end
			it "doesnt changes attribute" do
				@user = create(:admin, name: "Joe", email: "me@gmail.com", password: "foobar", password_confirmation: "foobar")
				put :update, id: @user, user: FactoryGirl.attributes_for(:admin, name:nil, email:"something@gmail.com", password:"barfoo",password_confirmation:nil)
				@user.reload
				@user.name.should eq("Joe")
				@user.email.should eq("me@gmail.com")
				@user.password.should eq("foobar")
				@user.password_confirmation.should eq("foobar")
				@user.email.should_not eq("something@gmail")
				@user.password.should_not eq("barfoo")
				@user.name.should_not eq("Bob")
			end
			it "re-renders the edit method" do
				@user = create(:admin, name: "Joe", email: "me@gmail.com", password: "foobar", password_confirmation: "foobar")
				put :update, id: @user, user: FactoryGirl.attributes_for(:admin, name:nil, email:"something@gmail.com", password:"barfoo",password_confirmation:nil)
				response.should render_template :edit
			end
		end
	end
=begin 
	describe "delete method" do
		it "deletes user" do
			@user = create(:admin)
			expect{delete :destroy, id: @user}.to change(User,:count).by(-1)
		end
		it "redirect to users" do
			@user = create(:admin)
			delete :destroy, id: @user
			response.should redirect_to user
		end
	end
=end
end