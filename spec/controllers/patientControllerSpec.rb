require 'spec_helper'


#RSpec.describe User do
describe PatientsController, type: :controller do
	before (:each) do 
		@patient = FactoryGirl.create(:userPatient)
		controller.current_user = @patient
	end 
	
	it "should have a current_user" do
	 	expect(controller.current_user).to_not be_nil
  	end

	it "patients views their profile" do
		puts controller.current_user.id  
		get :show, {'id' => @patient.profile.id}, {'user_id' => 1}
		# expect(assigns[:patients].id).to eq @patient.id
		expect(response).to be_success
	end
	
	it "should redirect properly" do 
		get :show, {'id'=> @patient.profile.id}
		expect(response).to render_template :show
	end
	
	it "shouldnt be able to create a new user" do
		get :new
		expect(flash[:notice]).to eq("You do not have permission to do that.")
	end
	
	it "should fails to create patient and redirect to sign in" do 
		get :new
		expect(response).to redirect_to signin_url
	end

	it "patient shouldnt be able to create new patients" do 
		get :create
                expect(flash[:notice]).to eq("You do not have permission to do that.")	
	end 
	
	it "should edit patients name" do
		get :edit, {'id' => @patient.profile.id }
		expect(assigns(:patient)).to eq(@patient.profile)
	end
	
it "should update the all patients info" do
	put :update,{'id' => @patient.profile.id, 'patient' => {:weight => 2, :emergencyContact => "Bob", :emergencyPhoneNumber => 12345, :height => 2, :familyDoctor => "Lisa"}}
	assert_equal 2, assigns(:patient).weight
	assert_equal "Bob", assigns(:patient).emergencyContact
	assert_equal "12345", assigns(:patient).emergencyPhoneNumber
	assert_equal 2, assigns(:patient).height
	assert_equal "Lisa", assigns(:patient).familyDoctor
end

it "should update the patients weight" do
        put :update,{'id' => @patient.profile.id, 'patient' => {:weight => 2}}
        assert_equal 2, assigns(:patient).weight
end
it "should update the patients height" do
        put :update,{'id' => @patient.profile.id, 'patient' => {:height => 2}}
        assert_equal 2, assigns(:patient).height
end
it "should update the patients weight" do
        put :update,{'id' => @patient.profile.id, 'patient' => {:weight => "wrong"}}
        assert_not_equal "wrong", assigns(:patient).weight
end

it "should update user attributes of the patient" do
	put :update, {'id'=> @patient.profile.id, 'user'=>{:name => "Bob", :email =>"something@gmail.com", :password=>"barfoo",:password_confirmation => "barfoo", :old_password => @patient.password }}
	assert_equal "Bob", assigns(:patient).user.name
	assert_equal "something@gmail.com", assigns(:patient).user.email
	assert_equal "barfoo", assigns(:patient).user.password
end
it "should not  update user attributes of the patient" do
        put :update, {'id'=> @patient.profile.id, 'user'=>{:name => "Bob", :email =>"something@gmail.com", :password=>"barfoo",:password_confirmation => "barfoo", :old_password => "wrongpw" }}
        assert_not_equal "Bob", assigns(:patient).user.name
        assert_not_equal "something@gmail.com", assigns(:patient).user.email
        assert_not_equal "barfoo", assigns(:patient).user.password
end

it "should not  update user attributes of the patient" do
        put :update, {'id'=> @patient.profile.id, 'user'=>{:name => "Bob", :email =>"somethinggmail.com", :password=>"barfoo",:password_confirmation => "barfoo", :old_password => @patient.password }}

        assert_not_equal "somethinggmail.com", assigns(:patient).user.email

end

	it"shouldnt update the pw" do
		put :update, {'id'=> @patient.profile.id, 'user'=>{:name => @patient.name, :email =>@patient.email, :password=> "barfoo",:password_confirmation => "barfooo", :old_password => @patient.password }}
   		@patient.reload
		assert_not_equal "barfoo", assigns(:patient).user.password
		assert_not_equal "barfooo", assigns(:patient).user.password

	end
end
