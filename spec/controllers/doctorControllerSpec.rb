require 'spec_helper'

describe DoctorsController, type: :controller do
	before(:each) do
		@doctor = FactoryGirl.create(:userDoctor)
		controller.current_user = @doctor
	end
	
#	index
	it "should have a current user" do
		expect(controller.current_user).to_not be_nil
	end

	it "should find their profile" do
		get :index, {'id' => @doctor.profile.id}, {'user_id' => @doctor.id}
	#	expect(responce).to be_success
		assert_equal @doctor.profile, assigns(:doctor)
	end

#	show
	it "should view their profile" do
		get :show, {'id' => @doctor.profile.id}, {'user_id'=> @doctor.id}
		assert_equal @doctor.profile, assigns(:doctor)
	end
	
	it "should beable to view other doctor profiles " do
		@doctor2 = FactoryGirl.create(:userDoctor)
		get :show, {'id' => @doctor2.profile.id}, {'user_id' => @doctor.id}
		assert_equal @doctor2.profile, assigns(:doctor)
	end	
#	new
	it "should not beable to create a new doctor" do
		get :new
		expect(response).to_not be_success	
	end

#	create
	it "should not be able to create" do
		get :create
		expect(response).to_not be_success
	end

#	edit
	it "should go to the edit pages" do
	   get :edit, {'id'=> @doctor.profile.id}, {'user_id'=>@doctor.id}
	   assert_equal @doctor.profile, assigns(:doctor)
	end

#	update
	it "update the doctors attributes" do
		put :update, { 'id' =>@doctor.profile.id, 'user'=>{ :name=>"Bob", :email=>"something@gmail.com", :password=>"barfoo",:password_confirmation=>"barfoo",:old_password=>"foobar"}}
	assert_equal "Bob", assigns(:doctor).user.name
	assert_equal "something@gmail.com", assigns(:doctor).user.email
	assert_equal "barfoo", assigns(:doctor).user.password
	end
	
	it "should only update the name" do
		put :update,{ 'id' =>@doctor.profile.id, 'user'=>{ :name=>"Bob", :email=>@doctor.email, :password=>@doctor.password,:password_confirmation=>@doctor.password,:old_password=>@doctor.password}}
        	assert_equal "Bob", assigns(:doctor).user.name
	end
	
	it "should only update the pw" do
		put :update, { 'id' =>@doctor.profile.id, 'user'=>{ :name=>@doctor.name, :email=>@doctor.email, :password=>"barfoo",:password_confirmation=>"barfoo",:old_password=>@doctor.password}}
		assert_equal "barfoo", assigns(:doctor).user.password
	end
	
	it"shouldnt update the email" do
		put :update, { 'id' =>@doctor.profile.id, 'user'=>{ :name=>@doctor.name, :email=>"somethinggmail.com", :password=>@doctor.password,:password_confirmation=>@doctor.password,:old_password=>@doctor.password}}
	         assert_not_equal "somethinggmail.com", assigns(:doctor).user.email
	end
	
	it "shouldnt update the pw"do
		  put :update, { 'id' =>@doctor.profile.id, 'user'=>{ :name=>@doctor.name, :email=>@doctor.email, :password=>"barfoo",:password_confirmation=>"barf0oo",:old_password=>@doctor.password}}
                assert_not_equal "barfoo", assigns(:doctor).user.password
		assert_not_equal "barf0oo", assigns(:doctor).user.password_confirmation		
	end

	it "should not update the doctors attributes" do
                put :update, { 'id' =>@doctor.profile.id, 'user'=>{ :name=>"Bob", :email=>"something@gmail.com", :password=>"barfoo",:password_confirmation=>"barfoo",:old_password=>"wrong"}}
        assert_not_equal "Bob", assigns(:doctor).user.name
        assert_not_equal "something@gmail.com", assigns(:doctor).user.email
        assert_not_equal "barfoo", assigns(:doctor).user.password
        end
 it "shouldnot update the pw(to sort)" do
                put :update, { 'id' =>@doctor.profile.id, 'user'=>{ :name=>@doctor.name, :email=>@doctor.email, :password=>"foo",:password_confirmation=>"foo",:old_password=>@doctor.password}}
		expect(response).to_not be_success
                assert_equal "foo", assigns(:doctor).user.password
  
      end
end
